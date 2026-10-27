Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112029;
	b=BVaQOHzL+H6LsnhU710R/AdsPyKB/2kjzW3G2yymz/dvHvBvWQ8CjESxvrvQ039/HGdY
	 sVgyVnJJHiYE6RV/nyT/cSTycHPKNlCDVlKm8WGve0CFNsdgqdedOnnrd4bP8JpkVownV
	 rFlYsDp8sLNL5YTD6eYwWI4JbyB4gXZJ5AfPNsZV7Se9Jcbs822GMJDr576Uu9L37RW6r
	 9EqUt3kQzpElSmILuZxDb478dm+xPjuzzpIHM7QOSIpJpU9q0NK30ApnOg17BfdPNtITP
	 A4WkdnhFPkCJsA413EmeJvnPnBKwMhhxW9MnbWPW/3BjI9c//dyy3D/v8gZz7GRB3Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112029;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IK2BoLPCSCQEkRIc6Ai1YWmPmuAmq3Vm7WFWqv9pOTA=;
	b=Y8Mctl5we2FvroTAZVC+3ASjr8kwKJRu6Yra1VrkWqArSAjaetaEZ2ofU7VwiuJXtrnX
	 x84ctSNHb6fO6RlwSgFkwAYE4Tim5Tmoxh9fEjbMLt+DI2qQVkV3oOwJq9kimu4drPpUn
	 7yTLXbPt2i/sWJ4SegPqFtNbhUFjlGDi6iLXHsXVTBEn9nLEvsbyhTHhQSpUQwt5Y5F0/
	 Dri+WkP0B/Gtfuay9Q3c/Yota0u5ZURCRNVIzGj6Cj68hkddY/KyXEmupAP4Wq/gPNOsH
	 lDvQq4b4mj4s9vIGX04c4cKeVeigNcjkGUT5JkECohOYqmGCl5PhDhUGphSWJguY1sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LyPL3QPs;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tH6paY4x;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77726606A322
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77726606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LyPL3QPs;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tH6paY4x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793112027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IK2BoLPCSCQEkRIc6Ai1YWmPmuAmq3Vm7WFWqv9pOTA=;
	b=LyPL3QPsFQ1Q2V1kwldpEoZWbOONsyX55ZjXizEJy82g6DZ3RVIoay3OSfWfHF4YJbBoul
	Ko5Blz9sJVQvsItUg3g3LNDVrT2cL+Zc7dGmxMbMIoQsdy23pw9AHFJNJGMnK7jfme1DIM
	busEdKgDn7D1gwfdij0T4JLdbDUywmA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-CKBBzeU5OEWzKEOewZaPKA-1; Tue, 27 Oct 2026 10:40:25 -0400
X-MC-Unique: CKBBzeU5OEWzKEOewZaPKA-1
X-Mimecast-MFC-AGG-ID: CKBBzeU5OEWzKEOewZaPKA_1793112024
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso27998955e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793112024; x=1793716824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IK2BoLPCSCQEkRIc6Ai1YWmPmuAmq3Vm7WFWqv9pOTA=;
        b=tH6paY4xo5YQGUZhxfrKgN8eyjp1Aq0SyM44wgjeC544b/dxbKypogullLAYLc3Y6P
         VkDg1U4IMbOiomb2nAI0pLJb49L7Guxw1zTYImcqALbe16MYAfDyefijf8FtyDsUokWi
         G8QDKKyYABxwuWvJ0n54DTXNw9FWYkmlyG0N6U9im17vkrmfCTI1qgL5Z0OoU21mbIBz
         r5r9cj2F981nEJ7iAtYbT6FSBtqcU46yIqdUcVcxFmRiYH5UY6q0Dl8jtjaQPi6t4je0
         kicZclYzHdpdC/QH4YktyefLbYNxWG/zqhtMg7jur/+tGPBPMafMU3Zma5DyoJIPv2Op
         JHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112024; x=1793716824;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IK2BoLPCSCQEkRIc6Ai1YWmPmuAmq3Vm7WFWqv9pOTA=;
        b=MLHKmIDgKNx9A9k34jU9o36GTp5ey7m/UWFPxghwsnccrnsc++tIfpfYpFSZZiUAHi
         RYFkunRyK/Ve3zj8mpoVp74FosSosojm7O6wmRNVxNM6XhjxE0ZEqz9gufebtWYt/jJK
         BkRbZ8GJOYLloXOC951V8XxTlbXAtpKXfmmPSKN+gIBr6LvP8XXa+4v295qOXksRnNca
         rfqvAva/ZRtw2muweTP5UHXXTQa8VzXY6amaIRCmaJ2QyVkZZ0DQd+2BotxMGKfIhsEP
         XbKOsTo+9Ye/IXg9LA4xI/prSbkvvfCMN2Q1IYLi1+pYtEBEFmS0r9r/W//ta4A64e1p
         pn6w==
X-Forwarded-Encrypted: i=1; AKwUvBxd01ox6H7RFxBfakBCS/Ne/77vcRwegO9GhD9OCOyayABoh2MuQm2AD7Rapmhggbq0GpVABtg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXDiBDiSB5fHBgK6anX2QUZZPWDlBXBf0KXF/mTKDQIJdmtH3t
	550T54KZDdHs7ZbRqkEmg4vtQ4IStMt6GABHJ5A6WK5Zc2f6TOHm36pU3FJow0BKM1QAU8O9Omx
	QkJEGcBQRnPc9l9kJPsViTiLgNZW3MF8N52NfyoKb8QxNTOQjT5ODN4TzVw==
X-Gm-Gg: AYBFou0HWrqPISLuHpMza7webLseDbpWjPSdFwMdcPJfzGkCuHlL4E7YcT+3y3B9MgC
	HEszKBIt5Wp2T0wMoF0L4vkMQOk0IxeHlzKbmqACWydgAY6Hv3CZl9uMXhz3fu+9RYpnfWuVAH9
	CXkDPn+pfAUoeiOifhZQxYPjMPj82OH/IsmE1INZcsU8E94uK5p2elb6wnKw9IyRdDHTRCOyog8
	Q9DRvdclilAN9KmFC7Tc8fiXyFrxdFozPdXSXDE1aysP/fLj6S5SE6xdZmIEOQpWa/t0Rxj7uj8
	ET56b6MlEq5R1MkQP8Q+7c9JXHdINCHVGYClGQFumpaqLjChRsKMw3CbptnkZFII1sJJOgnA4TV
	DpWGQ5wNDpx7Qp4pIu8diMrlAa5p6a+RcJwffCW+7yotcxZ4fpPsWckFvQlmCMiv4QLS0k3ccVw
	==
X-Received: by 2002:a05:600c:474a:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4a35ac91f2amr208745395e9.16.1793112024324;
        Tue, 27 Oct 2026 07:40:24 -0700 (PDT)
X-Received: by 2002:a05:600c:474a:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4a35ac91f2amr208744515e9.16.1793112023755;
        Tue, 27 Oct 2026 07:40:23 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa097sm299551775e9.3.2026.10.27.07.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 07:40:23 -0700 (PDT)
Message-ID: <5abb5015-eee0-41a6-a4b6-5ca9ed0a9f0f@redhat.com>
Date: Tue, 27 Oct 2026 15:40:21 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 00/13] ice: E82x: timestamp processing logic fixes
To: Jacob Keller <jacob.e.keller@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Nowlin <alexander.nowlin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 00:12, Jacob Keller wrote:
> Jake Keller says:
> 
> This series contains several related fixes for the ice driver PTP logic
> relating to timestamp handling and device (re)initialization.
> 
> Of particular note is some changes around the handling of timestamps that
> are requested near device state changes such as administrative up/down
> cycles and link change events.
> 
> The E825 device logic in the PHY has an internal counter which is used as
> part of the "threshold" logic which determines when the device will trigger
> an interrupt signal from a given PHY port to the MAC. This internal counter
> requires some precise handling to ensure that the internal device state
> remains in sync with software expectations. Otherwise, the device can be
> finagled into a state where the PHY stops producing new timestamp interrupt
> notifications to the MAC indefinitely. This in turn degrades the timestamp
> processing latency and results in application failures for common
> timestamping applications such as ptp4l.
> 
> There are four major categories of problem resolved by this series:
> 
>   * Timestamp requests made while the PHY_REG_TX_OFFSET_READY bit is cleared
>     will increment the internal counter, but leave their valid bit set to 0.
>     Upon read, the counter is not decremented. This leads to a desync of the
>     counter and blocks the PHY interrupt.
> 
>   * Software logic for tracking timestamps incorrectly cleared in-use bits
>     without waiting for completion in certain cases. If the timestamp *does*
>     later complete, it leaves an "orphaned" ready bit which is not
>     tracked by software. This results in the internal counter becoming
>     desynced if that index is re-used.
> 
>   * The PHY timestamp memory region lacks pull-down zero-initialization at
>     power on, resulting in uninitialized random data in the memory region.
>     If software reads these values, an entry with its valid bit set to 1 can
>     trigger a counter decrement and cause an underflow which results in the
>     counter becoming desynced.
> 
>   * Timestamp request which complete near the beginning of the PHY losing
>     link can become "stuck" such that the hardware logic triggered by a
>     timestamp read does not activate. The memory status bit and the valid
>     bit in the timestamp index are not cleared. This window where this
>     may occur begins *before* the firmware notifies the driver of link loss.
>     When this occurs, the driver may accidentally re-use a stale timestamp,
>     and the IRQ re-trigger logic triggers a repeated IRQ "storm" that can
>     consume significant excess CPU time.
> 
> The series' primary focus is towards preventing driver flows that can
> trigger the above sequences. It is based on work from Przemyslaw Korba which
> was previously posted at [1]. During that series development, Petr from
> RedHat reported the 3rd issue mentioned above. While attempting to root
> cause that issue, several other issues were uncovered and those fixes have
> also been included in this series.
> 
> First, the PTP reset flow is fixed to stop tearing down the Tx tracker
> during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
> permanently after such a reset. The fix also ensures that all teardown
> paths properly release the tracker and kworker in a safe order. This issue
> was found by Sashiko during review of a previous version of this series.
> 
> Next, the locking around the PTP ports list in the adapter structure is
> converted to use RCU primitives and a spinlock, resolving a couple of
> reports from Petr about places where the original list was accessed without
> lock protection. Note that an older version of this fix used an xarray
> instead of the list. The xarray has more overhead and results in an
> increase of ~25 microseconds to the average latency for processing Tx
> timestamps. The list is simpler and avoids this overhead.
> 
> Next, the PHY restart locking is fixed to avoid an issue with a concurrent
> execution of ice_ptp_restart_all_phy() and a link change on a given port.
> Additionally, the PHY port locks are merged into a single per-adapter lock
> to reduce locking complexity.
> 
> Next, the ice_ptp_request_ts() function is updated to sequence the marking
> of the in_use bitmap in order to work properly with the lockless reader in
> the IRQ thread. This issue was reported by Sashiko during review of a
> previous version of this series.
> 
> Next, Arkadiusz and Jake modify the driver to stop pretending that the link
> has changed at administrative ice_down() and ice_up(). This removes
> "virtual" PTP link changes that occurred on several flows including MTU
> change, Eswitch setup, and others. Now, the driver only triggers a PTP PHY
> timer reinitialization when the physical PHY link has changed instead of
> during many other actions.
> 
> Next, come two fixes for E822 hardware that were originally posted as part
> of Przemyslaw Korba's work [1]. The E822-only "vernier" offset validation
> work task is properly canceled during device reset, and new timestamp
> requests are kept disabled until the validation task completes.
> 
> Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
> bit. This bits only purpose is to tell hardware to mark any captured
> timestamps as invalid. Since this also disables the necessary side effects
> on read it is problematic to have cleared. According to hardware engineers,
> keeping it enabled should not have any other side effects. Instead, the
> tx.calibrating field is used to disable new timestamps from software in a
> similar manner to the older E822 devices.
> 
> Next, the driver is modified to clear the PHY_REG_TX_MEMORY_STATUS by
> reading each index *prior* to the PHY soft reset. This ensures that any
> stale or invalid data left in the memory array is cleared, followed by the
> counter being reset via the PHY soft reset procedure.
> 
> Next, the E825 timer start procedure is modified to first include a soft
> reset. This ensures that upon link up the device is reconfigured from a
> known-good state with its internal counter reset and everything cleared.
> 
> Next, Petr modifies the ice_ptp_flush_tx_tracker() function to wait a little
> bit for any outstanding timestamps before flushing.
> 
> Next, Petr modifies the ice_ptp_process_tx_tstamp() function to avoid
> releasing any index from software unless either a) it is actually completed
> by hardware or b) it is timed out waiting for a full two seconds. This
> closes the final gap from the second issue mentioned above. Instead of
> immediately releasing the index, the software now waits until hardware has
> completed it or the driver has waited long enough to be sufficiently sure
> that no such timestamp will be done.
> 
> Finally, the ice_ptp_process_tx_tstamp() function is modified to verify
> that hardware actually cleared the ready bitmap. This ensures that we do
> not report false timestamps near a link down event.
It's not trivially clear to me if the patches 2,4,6,8,9 and 12 are
functionally independent from the other ones. Are they? If so, we
could apply them, keep the remaining series smaller and hopefully
move this forward.

/P

