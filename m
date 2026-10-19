Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521B4A2A5F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404550; cv=none; b=SLE900NlGTSgRFVhh2In0TSHV4Jr2KrlKF0vU+mVVCGSn1aGMfgihzjTGi2LaMoWE3Mu7BW50Lu0z28PpOYFhrmMsT9Rf1XGhyX0YlLR4h1ExyIPY7jpVYqc+vYB9JHmbeqoIPouGyerPi7cfJNuFmaWUdzPCBPYsslkjyAWu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404550; c=relaxed/simple;
	bh=QoQK/kdHldyPvMQ5dW8PaBXStij6P0wjcMNlvVILmvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr4h+xbYTtDmp2k95YtdmQNgNvZ5XnNmQKeFUJKOtP62M6p0JTfzplwKfQ1R2qyy+Q9jveCrp+oufeduS8UyYFf74J5PJAaKSt8qSKmCN67quszUSGbNSY9TD+IoK4GBIy1/ugRDR9+tNTAIuIbwWJ0aiCtIVhomAQ+pJHpz5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guDw5IHB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qCGs9qPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guDw5IHB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qCGs9qPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792404547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1kyYaAz8+24p19YS7FhB0fj4LUm2ZTPvS5HDwK3dJc=;
	b=guDw5IHBDOskp8/QKuivtqVpTIEzEQwPlpQyp2coD9ysuxPrTvt7gSsjo5w0KdOG72Qv6j
	ijZzq6nMWgSb4YQ/UM0OUMx6zZ7UuzM5Sx27BGEw5vF/nypRrZVTiZvICb8tqQNDVWd0iX
	UH01rZWatfrQ7q8tdSCJDKyvEHiHPVM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-T8PBjhQiMCK5vv5qbT45Vw-1; Mon, 19 Oct 2026 10:09:06 +0000
X-MC-Unique: T8PBjhQiMCK5vv5qbT45Vw-1
X-Mimecast-MFC-AGG-ID: T8PBjhQiMCK5vv5qbT45Vw_1792404545
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b0a199b20so1715796f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792404545; x=1793009345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S1kyYaAz8+24p19YS7FhB0fj4LUm2ZTPvS5HDwK3dJc=;
        b=qCGs9qPwT5aOOMdHzCpszP1Gi+dvR5FCtXmar8tLcfzi+uR4lSs/lnIQ4LeCT8/Lp9
         8qs767VBtg3fF9fvdh4Eb1ywvgax3gYOIm3/3/RymyXRAWqnIxUd2jupQKc7UehXa6g2
         KQeHbw2jaPtM5oGePSTkDtUXH2slfvNtm9MXkJ4+PpsLNFK/A0Dv/+xzrGLzA+RvUa/i
         gpT7D1Gb7ZANj7jqS8RxLWDkGp1dedoz0EWUKg6+ZXz0XpP2UCR2KYj86Ct+ermftLQY
         bTgFhEUccXhY2lRUUrhj55U5dF9lFhgg8koZX7gZGck98EWWfO/OMhRBnUYlZY8tUntp
         0/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404545; x=1793009345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S1kyYaAz8+24p19YS7FhB0fj4LUm2ZTPvS5HDwK3dJc=;
        b=2xIwIrTGlMsw6iQuSD18GkR0ebOFPdD7ybe7lAxTctG9JENH6Mt40JjZo0VeE8c3dG
         SCGRmTpVH+mUFmohF4lHGTjO+njEHFCsR/AsJSum8DENWvzIwtpPrpQh17ZSQ7frtEW6
         sqJcSq1l+p6ZaarByke/JG+cuswJQajSPkE9ICBPuTspwLMPgta6iyrNvGQOCbCBoKBc
         hUXHF5DgtPldukt2I2m6vMYgYxMDjWcd8l8omn8RZYaSujAVGjh04GB3sxCyuogVWDRO
         2/+0k7eouBxSey+Doo3Pz8/vfuHnN/yeKeY4nptlH0T9vqtcpxrrByNEiwpc9If+Wxgf
         kagw==
X-Forwarded-Encrypted: i=1; AKwUvBzdkW5meWyyEvI7P+adNLwtInba5uwlbvJbDKRH1RpHVYJ5zmILSv6SZ6UASCiisvgjYryqTWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRnMY0n54K/Y1h6yJhZyoF7MVV+bVdaSV82KTHFJfwGeF172mr
	1vXNWippMwxng0xGQrwqqZwSoyz0FZmvgRP1sMkyBbCxWaXPLURWUYTtoEKHOsC+pUDndgpDuQ3
	q2+vhgLep4JJSFHqUPFLs3J2ivCcjQmPosPVo5/nkZftQVkqu6FgBjhsAuw==
X-Gm-Gg: AYBFou1KMyS6xFagYkv/9rvjHOeHefpqMdBaOwiTp+WKDm7nM64WJqhfXs5DZn9q5F7
	q2BGfcB+FtTjazQdfSWrCgnJqlAjNg7Bu0U0pfQrD50qL6E2Y25fKkVCo/b/LcNA4AIW5l6J90q
	vJVbRPYJbLCt/k2RVBZKJufFddbjkcj7nGoVkvbV9eJ6h5uRL0Bq9OatP7/ClsMQD2589L6NB5p
	uQp5rOiCBS6BY+z6fjKIY2gYUshAHK1aEsWaoClnDyvM0iZZPWc1CUs3uzVsp6n6pmuYoV4461e
	S2riD0owHKYLOZl2ab6vk74FkFnCwmQ5uy+atqIuFWsv223Ieh27bX3M0fZHIlzXdzQm9w==
X-Received: by 2002:adf:e189:0:b0:487:27f9:842 with SMTP id ffacd0b85a97d-48e07fbeffcmr15398399f8f.55.1792404544895;
        Mon, 19 Oct 2026 03:09:04 -0700 (PDT)
X-Received: by 2002:adf:e189:0:b0:487:27f9:842 with SMTP id ffacd0b85a97d-48e07fbeffcmr15398333f8f.55.1792404544324;
        Mon, 19 Oct 2026 03:09:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503862sm21999178f8f.46.2026.10.19.03.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:09:03 -0700 (PDT)
Date: Mon, 19 Oct 2026 06:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pranjal Kumar Singh <pranjalksingh92@gmail.com>
Cc: cve@kernel.org, netdev <netdev@vger.kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>,
	openvswitch <dev@openvswitch.org>, stable@vger.kernel.org,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: Kernel bug report: unguarded deferred skb_checksum_help() writes
 corrupt the previously-validated IPv6 fixed header (IPv6 counterpart of
 commit 6785011f8b16, "ipv4: validate checksum_start before completing
 checksum")
Message-ID: <20261019060131-mutt-send-email-mst@kernel.org>
References: <CA+UYBZDMpqq989aWq318+T2j4+PU7giVpO8ZffrkDFwqaoKjJw@mail.gmail.com>
 <20261019044815-mutt-send-email-mst@kernel.org>
 <CA+UYBZCEe3C2HuqgZSZ9Xa7MUxCNy=9ckBmA1Kyjmt882ZRQBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+UYBZCEe3C2HuqgZSZ9Xa7MUxCNy=9ckBmA1Kyjmt882ZRQBA@mail.gmail.com>

On Mon, Oct 19, 2026 at 02:36:14PM +0530, Pranjal Kumar Singh wrote:
> Yes. One 16-bit csum_fold() write at
> csum_start + csum_offset, always within the packet's own linear data
> (admission's pskb_may_pull(needed) bounds it), so no OOB, no memory
> safety issue and no crash; just a previously-validated header field
> changed after the stack committed to it.  With the IPv6 geometry I
> reported (csum_start in [20, 40) slipping past nh_min_len == 20), the
> write lands in the fixed IPv6 header only -- dst/src bytes; version,
> payload length, nexthdr and hop limit (bytes 0-7) are unreachable from
> that geometry -- and the written value is attacker-derivable
> (precomputed csum_fold in the reproducer; wire value matched byte for
> byte, control run intact).
> 
> I went through the full v2 series: with 4/7 my geometry is resolved at
> ingress via the mismatch path (Routing-header parse -> csum_start !=
> thoff -> completed before protocol processing), so the observed window
> is closed on the virtio-hdr-tested flows and my sink-side patches are
> superseded for that case.  I'll repost them (or thin them further out)
> as a net-next follow-up to your v3 only for the sysctl opt-out case in
> 5/7 (knob off = my geometry is admitted fully intact with
> CHECKSUM_PARTIAL retained and the deferred write happens as before),
> plus the xt_CHECKSUM v6 / nf_queue / xfrm_output family gates, which
> 0/7 doesn't touch.
> 

I don't get what this all means What sink side patches? 0/7 of the
patches I posted touches what code? I don't think it makes sense to look
at that sysctl deep in the net stack, if that is what you are saying.


> On Mon, Oct 19, 2026 at 2:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Mon, Oct 19, 2026 at 02:13:04PM +0530, Pranjal Kumar Singh wrote:
>     > Hello Security Team,
>     >
>     > The IPv4 part of this was fixed some time ago in commit 6785011f8b16
>     > ("ipv4: validate checksum_start before completing checksum"): a packet
>     > whose virtio_net_hdr csum metadata points its checksum start inside the
>     > IP header makes skb_checksum_help() (the deferred csum completion)
>     > rewrite the header the stack has already validated (fixed checksum
>     > offset-width write at csum_start + csum_offset).  The IPv6 paths were
>     > not covered, and they still are not: a 2-patch series mirroring that
>     > commit for IPv4->IPv6, including its remaining not-yet-IPv6-guarded
>     > sinks, is reproduced below and attached as patches/0001 and 0002.
> 
>     Thanks, I think this has been reported already. Just to clarify, the effect
>     is just packet header corruption past validation, right?
> 
>     See [PATCH net-next v2 0/7] more virtio-net csum hardening
>     for WIP fixes.
> 
>     --
>     MST
> 
> 

