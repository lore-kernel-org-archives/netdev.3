Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549752120E
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860467; cv=none; b=Im3vggPCtL/2nyhLI57pfYU+lwV/v3Smkoxpg65M4JsUlLopoXZfiLHhn4QYWqN7pur2Ivv5fGxsOG7syMgg+Trf09GALW3zCtK5vXMwTqytltrPl/HcpvJhjmjs8WpZ2Jdo1NAeOrzEFLYCJikVckjtuoe2tP4mF2Ute1zHNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860467; c=relaxed/simple;
	bh=DTDuPiPpm6rdRyHKJPIMLZWiMdIa8IPYFpClFyVz7UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+olTksUUoJIUdCKlQTThCfo3VHDdztQMkJvtEb/wbkp70R0rYz2cuHMsHZIbhxXZUHH9WcP5Gw9ZHcgijvCEPd6z1y7r+AZeF+uBT4I6IVfJFXltR1atSzCldq+DopmiutFlH66Ht6hkMlQfs9SIUtP06/C9/A3MEI6mJesWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7NlH24V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CW281M8l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7NlH24V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CW281M8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788860464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tOd0ojv4D8fJX0idO1L7vxijS7nq4b/TbHiud0PGeA=;
	b=S7NlH24VjpZm+B5JFy9+Z9hHmCq7J7VXmzeEflGyo48fclTTmYHKKKz6XWv5YoDNd1QjiJ
	D9nSdujAjyZNdua5L37pyAP+wH/ROxjTaorsveDJZ/F2a1CZ++Z0qEXj3/Ld32mVlET9iO
	njrUGQ4YMQSUUVU/Pv4xpIGAdxNWRqY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-NEOSgX9NMKqOFZRPIcdpKQ-1; Tue, 08 Sep 2026 05:41:03 -0400
X-MC-Unique: NEOSgX9NMKqOFZRPIcdpKQ-1
X-Mimecast-MFC-AGG-ID: NEOSgX9NMKqOFZRPIcdpKQ_1788860462
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495529a93f9so43382885e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788860462; x=1789465262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6tOd0ojv4D8fJX0idO1L7vxijS7nq4b/TbHiud0PGeA=;
        b=CW281M8lMdtCIOIqoZFDIgOA0GsJ9M7CW4FGVIJ3AQNKP1B2l3ylw3hYv1frIkSxQX
         w/iy+yFrgbpnAsqlCuI4H3Q+NKsNOIlVwGGR3NbU+PXsSjPSpNk4GJhXe/fSi9ZK6OOi
         CXGv8Twz/I/UB4E7IYCHpe785V4McYVF3G8B1lC+nXRMbCOwlouWQH2+umLEg1bPJC+s
         BI8eS9+x/5Ug6vDDBNlfuVwOC1wUpbeFteCHzm+FphgpwjbWgivOKa5OQRv/QBKgp77J
         SdU5tTi6sBTW3b2THtHkUuTbtX4bXi/jwU8dB99/sYsl34t2HFqImtr9rei2bIvA3yeV
         xACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860462; x=1789465262;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tOd0ojv4D8fJX0idO1L7vxijS7nq4b/TbHiud0PGeA=;
        b=Fc+tNGRYuzC16vxQP6fWT3k0hi6FAoMHoi/nl8eKuMjstsdhrfP74pVWjFfgoCuTFx
         AL3Ot8wkae7rf1x3w5AqG+oS4NtgLUu598Jx4NDIroxoodZQyGk6pc/84UfuGfwidlZC
         iSYK7vkfw2SrIRF6Mz4cRAGpUH/VF1qCN7qQrvm5WnDGbgr1TJBFfZ4lRN66qOodpYfA
         EsiTjSJJIgdDYphaQDYFywlDLGRS1AwdIIS9iVJHdZZ3WEQZkRtsbN4euPAcm7lFr1Nz
         XtsE2nPh5KRwB50kP47K/gsmV3ENwq/o3EIDOggzP4LQ7IhoD7tAXLg+voKgFgnWXriT
         MaKw==
X-Forwarded-Encrypted: i=1; AKwUvBzis47/dvNLG57aBDwn0cehxEjJ4/wbOt4Hh8W7ALgWIKAeXNsX0ioPKEyNyyBnAzyvHPRTlJA=@vger.kernel.org
X-Gm-Message-State: AFuF++lqNsGfSSZpVzklTmrMRDV7lazAW+n1MGm7dvQJBBJ3ZpPLsoWZ
	P2rNodZl2TaC73Phj91PK3mkW2yvuGCNEYOWbDgUEt2k+psGa1l+vdnXmdA3ob981uXxFcSQtV8
	rkcVRpSUlHgrqgnQGSlppNmuMWJzYN45I5svSO4a/QI0qarfeZiZVcJsxgA==
X-Gm-Gg: AYBFou3k0ZrBFSLO2DFIXg4DcecOhginhD0W7366ZX13tRrC+RsZUzZ2e+iBLRwhtjg
	UWHqk2EzTlqEM6ioqJh7We9i3jCkZk+JBX6gh4P7fePlIpTtMSSQdoH0qw7mOK/Vpc/BxZJvc9x
	QRWWufZAKTusOG38ZvBOh0LAvHrBWkMXYy8swRnhZXsQZFYA/TkJ9fzIDU/9yoV8jDt5fNfEv7A
	aNz6m5+qSJ+ysDvfEW2by6joOBzjYFuNkXakZaXnxwUYhnSwqpN0oLRh+kvResR44R4KuY+mnRa
	7vsH/Gqwi1Laff3wl3Px2NGDIzV/z40O/SkQYIQ81bernN6LdhP4+Z780rbwbErTyvjroH5/1jU
	NgVEfhQudgkUy72F2DD18//100iERYV+6YMkIaMaQQrQVTRaNZlH5ES1tq8iVYNfhc85KZu+0+g
	==
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr318807805e9.11.1788860462285;
        Tue, 08 Sep 2026 02:41:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr318807135e9.11.1788860461782;
        Tue, 08 Sep 2026 02:41:01 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023edsm446976855e9.7.2026.09.08.02.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:41:00 -0700 (PDT)
Message-ID: <470269ee-039e-48e6-8958-17534fd75812@redhat.com>
Date: Tue, 8 Sep 2026 11:41:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 0/4] eth: fbnic: a collection of fixes
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 Simon Horman <horms@kernel.org>
References: <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 12:31 AM, Alexander Duyck wrote:
> This series collects a handful of independent fbnic fixes for issues on
> released kernels, plus one core ethtool fix needed by the fbnic offline
> self test.
> 
> The first patch fixes a NULL pointer dereference on unbind after a failed
> PCIe error recovery: fbnic_pm_suspend() frees the napi vectors via a
> direct ndo_stop() while leaving netif_running() true, and when slot_reset
> -> resume fails the data path is never re-allocated. To prevent the panic
> we reset num_napi to 0 before we free the IRQs which prevents walking the
> unallocated napi vectors when we unbind the interface later.
> 
> The next two patches address the FW mailbox. One sets AW_FLUSH_MODE
> alongside AW_FLUSH when tearing down the Rx ring, so the write pipeline
> actually drains the staged requests instead of hanging on the BME halt.
> The other handles completions flagged with FW_ERR on both mailboxes,
> which the driver previously ignored. This resulted in us parsing a stale Rx
> page, and spinning the capabilities poll to a timeout on a healthy ring.
> 
> The last patch keeps rtnl_lock held on the ethtool ioctl path for the
> self test. Since the ioctl path became rtnl-optional for ops-locked
> drivers, fbnic's offline self test (which brings the interface down and
> up via netif_close()/netif_open()) runs holding only the instance lock,
> tripping a lockdep splat / ASSERT_RTNL and reconfiguring the device
> without the lock it requires. An opt-in flag restores rtnl_lock for
> drivers that need it.
I think some of the comments from sashiko (the high ones on patch 2 and
3) should be addressed in the same series.

Alex, please note that the current expectation is for the submitter to
treat sashiko comments alike to human reviewer's one, see commit
c82ff94592fb68f529afe63ca7f5ddb7dae4ba83.

/P

