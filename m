Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD54F6463
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860472; cv=none; b=MqFq9hQdG9YnsmoCwAaABKFSPVf6HXYz478mtkQN8HZW99NW10G0xwcDYo75dmLbMGAD/xeUc4KAdtaj2fOtrlzYVHQ/cEDEQMs0pfPLrjgjZzR6JLDP5FFbXeAUEkFHEGkLnpLB8ioDvlTaf5vUaTNWfSRgzwyScSe1r0SdDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860472; c=relaxed/simple;
	bh=DTDuPiPpm6rdRyHKJPIMLZWiMdIa8IPYFpClFyVz7UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bqkcxui7DHsV7dTa9eWsycrGt56kAW+/p1QmfwDtA7RyJjRdp5Fop9xnU4Zp3vTT9Bgg4vRIDQIgTDxQP2zek9CJzkfcxZEAmWcayp2eMvcbR6HYvvr8+NvosNvlLbrbJB5lf0AgB7BeTSi+Ik4pOUSr7y6JwyutzX42DOENyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WuzkAuaP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O79vUxUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuzkAuaP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O79vUxUy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788860470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tOd0ojv4D8fJX0idO1L7vxijS7nq4b/TbHiud0PGeA=;
	b=WuzkAuaPqXD/L7GMGIAcj7BdgXDFkLMT8pDVq6XHQt8rYpm6LEeNLpaJkxi6gbJoES3Kjf
	YEJQ3WplzSyDAMZp0QQUy1cfPJQ6hpxzZBOiBXxqGOIVW6r7PrHJAlK3aV6cFX7pp5e2ZE
	QOqEG3Nh5iCWkblNcphmc8CFazC3slI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-5i_nV_ZLM0-23nSf9dBuEg-1; Tue, 08 Sep 2026 05:41:09 -0400
X-MC-Unique: 5i_nV_ZLM0-23nSf9dBuEg-1
X-Mimecast-MFC-AGG-ID: 5i_nV_ZLM0-23nSf9dBuEg_1788860468
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4843e59c32dso2845043f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788860468; x=1789465268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6tOd0ojv4D8fJX0idO1L7vxijS7nq4b/TbHiud0PGeA=;
        b=O79vUxUyidbL3XDG8IBpmX3+KzvdPjceWIYsk9YGDxTmORVZG/dgCnStmufvfFb0zk
         oEst/S2l+XGZlQ44au9yR9P563gfq22u4nkAbtaV351nVgEQVjxEgiBVJj8FlAZDnr8d
         p5vICD2+MVrL2ZvBGKwdMuDwX6o+Vp4ZBinIMDvkoSDakvER6Brgv9v4AWYGrhAkoEeW
         BrPy3wdsSz5lv88TnqKSzA6AWE9vhbcmE7b6AviYGvQ9l9QCCttEKrKx+X+aUijNgX5p
         ruOGpwscQurIl30TUQk/l2qJqITJpmjbVx+TMlGTg2hStHGGZbWgDP4eVkQBVAfvpRWx
         EAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788860468; x=1789465268;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tOd0ojv4D8fJX0idO1L7vxijS7nq4b/TbHiud0PGeA=;
        b=l49/2aMdsTijP2/Hm5qAW9vQoir8o1p9gLw8Vdg73m3mT/+trTQBtg7kKPjpMIZTSI
         xu2nJAWxjvCRUkz8S+yq155odwmdb9rT56MhQOekJLQIpmNbZVpzn868wwt1q35EKZcC
         OpYdCHVqVQhT5QRQbtknzK1BHo5u74H7FMHYTRVTVRqHo7nmAyjadIgZUCh+iHKqbtSh
         QfHiV/6sLkM/2dKIBmEfoe+K9sJd/Cmkeg0mbN4ziUg/fAibcMhAFXeOEppKwwYTachp
         fuaw0uGJmRkeGiNzjXxOUH+NQ3RLe383DbPuH21/2dvyKv/W3KyZNiV/rCVtdzUAV5jg
         9oUg==
X-Forwarded-Encrypted: i=1; AKwUvBzQMMUBuCTymvIX7MM2wXKUtAagDX8uEHn7KGljIb4lxqLcZ7cNP7rDvaYJx2nIdSBXXqqu8pI=@vger.kernel.org
X-Gm-Message-State: AFuF++nzE5X3Y0kDKjPNMNnOHI2OXKH8RUleVaxHPXlZBpADFz5QCZqj
	mBtJZm+qfeBxZLH+9iGaN3wAkJOY21yyhkvQT3e2qBEBtkuIhggsZJ3c8mLn/ph5MvDk+1VIjb9
	TtYMec28UXvzPQib/58lXJ1TuGqSTqIlMtQaFzRQShSY8Nt0UzZSl3ade7w==
X-Gm-Gg: AYBFou3C2+AmuCxS9CWlEn4cIWTeK8L9rC0povkr+nNWCLL2QCD4iwvvRDj5YFFABJS
	YS0vh3CRSEy6FYtF0W7yqMTIhZ9f0ZLDvhccE+dlEUvVnrLBRcO2DjizgCQMFfk77w7o2zSirMo
	dNsWK5bFnmz1EtV8A+7wnuLF/vFDHtouSvHFsmRZjeWR1f+uFu5RKcNMVprzQIwV69H58PRiMEO
	E9i/v6t5FGhi5Rg4E0TlEhk/h8ZKHB0ipSjAS7qCqNLziTrTIVJwzYTYAP2sl4KA1CP7UYujEMr
	D4Gq9dHo+Cy1VyloPo0xWqMtrW0WXx1HUrc4y2nQ7KjNkRYEiinn0GdmoU6weH21P/G82ifuUVe
	EACV+hS7hYZ0d/sUvuvTTaign0qJC2b+AtNRhqyqBRJdG5x6MYrlrDagabajLHKHV/oaflkRrwA
	==
X-Received: by 2002:a05:600c:3551:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49cf8224cd8mr280698215e9.4.1788860467970;
        Tue, 08 Sep 2026 02:41:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3551:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49cf8224cd8mr280697815e9.4.1788860467498;
        Tue, 08 Sep 2026 02:41:07 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00a5b19dsm312299465e9.2.2026.09.08.02.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:41:06 -0700 (PDT)
Message-ID: <97beb3b1-95ce-4cfe-83b3-cbef9cd514cc@redhat.com>
Date: Tue, 8 Sep 2026 11:41:05 +0200
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

