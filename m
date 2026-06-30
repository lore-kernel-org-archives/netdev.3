Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7846AED1
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834661; cv=none; b=Hj6s9Yeedup5Q443X6Tk3RJO+Czso5gNzAtDpD5gPLd+b45mfPbFSEgzg5iJ6v5p4GbYBAsjtIzoif4Ua+KYkcg6UK4BIvqR3D72j460j2obP6ZLM7rI3YESboZhAfdiQeLBPdvb2Jpw2t4S1DbSQOdvjJOYTudTugKziQ9+aDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834661; c=relaxed/simple;
	bh=y7445ma5nY1rhw/uXHnIZ5XS0bGAch+rXU5qwFJ2m4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skSjANZF9N4tJvfsgztv6qr1Sn3bpgR7pEW3G+YhVqochOgRfpmPsthOvzqjFAoNXRPw94iGz5GRK1dnVjIz2M6FsyvlYiwJ/s39MuF5FGgPP88C7zkrH7GABcPyRyFMin2N2t4dIRcdpMptjKHuKOO1v4/7nY3AkV+f96QNTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RekldWY9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLuI900b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RekldWY9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLuI900b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwV1W6gFFKBGW/LHViHAoZIfwfYxa5BCshEu0mADzdg=;
	b=RekldWY9sqtiQt7reurE5gesgn5D1s3BOSXxmBaHL2tLXtDRAlUeCgrXMDzQOr4DQyabwS
	8YmzEJH188hfk/Mt3QMiaya0orP6B+RH1EgDShi7aF+NZbM/VwIdAWGsuZ2bZtvrZss4ti
	ggFkAPCWVqjygLj1esNrP5n70GAtbVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-SAu0FrlRPV67NKEjJ8sxKA-1; Tue, 30 Jun 2026 11:50:53 -0400
X-MC-Unique: SAu0FrlRPV67NKEjJ8sxKA-1
X-Mimecast-MFC-AGG-ID: SAu0FrlRPV67NKEjJ8sxKA_1782834653
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-492488f8583so50758725e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782834653; x=1783439453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwV1W6gFFKBGW/LHViHAoZIfwfYxa5BCshEu0mADzdg=;
        b=MLuI900b4byxc+NO8gA9nb0k6n4yGVosCghZDStglGANNKxdW4nXmjffwaARwT0grf
         LfJeV0gfipNQ532jsabp0Kk6ukTEZWKzpipMf6fuGSRrbsJWomXHCwJlwwKabrsLjStb
         U61Zt4aJz7c3q4Tk/2OrjNPVcAuHnb3K3ecsPg6ARK8QEp2rcZzMEthf5DmkX9bvHoXF
         AbRgnL+BRiU7zZNhoHlhSUbd8Rg2pgqeJHAlqf0Uaf+EU40MFlzxUj8io0y0+wosJReZ
         g10Rl4AoPWAggRoolpDEBq3uZoII3SXJ6vhbLyXEUi+ZT7AREyKoBCXBwLSV45aDUXCt
         XUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834653; x=1783439453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwV1W6gFFKBGW/LHViHAoZIfwfYxa5BCshEu0mADzdg=;
        b=RorbjRaIfuCJrC6EVFOkhY8CtV5rVVUz27As030eNHQ7irGnyjllHQ3DE+hQZS3SGM
         wyN1XTXzEjWTrm19SVfdQxPvDiOBSV+An8J32FhfzYCNSZkfh9USzD3wLFkwvI83gUWi
         0CHy0NJOyhbNGhv/KZlFG83onhWNi4lG5vqn+eM4u6M9sDRyJlXlImvU9BysGhLkR1aR
         wo2LF04nFcIP/afdhuNHU54vNIE0mDeoy9rS37sj7XZuxUPJyxMTMkpR/YZgasCevjHp
         dwAuxZywDpGdgHWHMqJ7IBvxAZO8AkHgqz2Dh/0tmzBO7m56xVh7ESNk2iDZok/tRBYc
         FjGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kjTo6utp6YoLLgxhLpkNV94W2w1BumDTpOFxbuEp6ohCkuqY6BxBIo1V37RI09djsgQhjfOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FnowxQvM5VZh6YUep04PQaW9khQ/vNAMouEUUIckRuyCNM+/
	Av3BXE09kwInLbxhSXFA8rprg/QPpsiaV/bzHyQF1SQde6TpvqfeekaukcbaSoV3MG7UekCIfb+
	9G+OsceNnR3RWC58PZOcCkcF/x3kwlHzUyZ6ezT6KXlI0RkOeB+regCCIyQ==
X-Gm-Gg: AfdE7cmvCRs+nJAyA6X0c0QgE+Ijte07CymOUtd7SDAB04t5ygGlRFWYqaYxF9Pn8jn
	8UUb+xHbibykEwZym9NjzfMROBwLpV4b4ACm3aQ4YSuXLNk+4BZY+ji5N6aOaCzTeNvD+fNYNkU
	pRQh1BKg/kP7Ym1e8HViuRPC7ArPBoKM5cU0AcXDvPtQpNB7zurVldl6dno9jptjSL8/doTxya3
	WvR93DGtWGyk8wl9Rw37Gw/wWcve8Q2QjkyDvBojZsuLwBBvp2njW8yKjm8k7ktmraDkZHXCbw/
	3sRUNXxVYZJvrueKWhgRvsrpLtxCsEm2Uar7iaIOBA0Qv/n6n32TVyW7PfyrWTVF6hVtvAz6sRR
	3gPNceAtC19f6iQNycDHkqAfRMkyygHxfNEry9IgVQ0bVyfHyISxbN1Il6IqZhjumnol5GN81mc
	bwY9CZU7mZjw==
X-Received: by 2002:a05:600c:6384:b0:493:a91c:37e7 with SMTP id 5b1f17b1804b1-493b82b8699mr62547125e9.28.1782834652777;
        Tue, 30 Jun 2026 08:50:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:493:a91c:37e7 with SMTP id 5b1f17b1804b1-493b82b8699mr62546705e9.28.1782834652326;
        Tue, 30 Jun 2026 08:50:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4540aesm5412535e9.0.2026.06.30.08.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:50:51 -0700 (PDT)
Message-ID: <5446388d-40be-43e0-8a55-eddd79ce71e3@redhat.com>
Date: Tue, 30 Jun 2026 17:50:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: stp: Fix a potential use-after-free when
 deleting a bridge
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org
References: <20260629072117.497959-1-idosch@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260629072117.497959-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 9:21 AM, Ido Schimmel wrote:
> The three STP timers are not supposed to be armed while the bridge is
> administratively down. They are synchronously deactivated when the
> bridge is put administratively down and the various call sites check for
> 'IFF_UP' before arming them.
> 
> This check is missing from br_topology_change_detection() and it is
> possible to engineer a situation in which the topology change timer is
> armed while the bridge is administratively down, resulting in a
> use-after-free [1] when the bridge is deleted.
> 
> Fix by adding the missing check and for good measures synchronously
> shutdown the three timers when the bridge is deleted.
> 
> [1]
> ODEBUG: free active (active state 0) object: ffff88811662b9b0 object type: timer_list hint: br_topology_change_timer_expired (net/bridge/br_stp_timer.c:120)
> WARNING: lib/debugobjects.c:629 at debug_print_object+0x1bc/0x450, CPU#9: ip/359
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Reported-by: Neil Young <contact@ssd-disclosure.com>
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P

