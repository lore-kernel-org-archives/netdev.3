Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793874;
	b=z5Q6vcxvW+dEDZ2VCkzdPOKEQdv9o6ku7rnRi7lFbPq9HTfXpGwV14ASmZJ3PzMHID7I
	 dXIB1RhSrMSfVwVPPIBn0cm2VVyVVBJ9G3f7pmPnjqfOFDbvVOMMAjzjcq1U4mOk2YHrn
	 1H8/1ExXlyVjeAI+ERp6b3ojO6tF27McAEckbLSQzh9aMgCQb8nrKa4mAoQ04KBKx8j7l
	 y8mt1q5sypT3PVuFMKJolm5+Oxqc/4EIg9YtDswAHpQ/PfIT3KRuGAhLevZpkPRpuAda1
	 7NKjiaxTwm6WA2w0e6GLF2jqMSbtwxIqgf0TsHaR3ElUyvYPwDoXQRtLxsLriADHLNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793874;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
	b=4oYGfAsnWjXYE8YT4uo+6pPbcGqQZXNsBwm8fiW5Bh2JLO1gPL+oLRjnzscupI2ZYnWW
	 JM8p9lTGqgQvoQgpi0qRD/pQccBhW2wVfGxujPXR+r/e50kuV6EWbCWXg5Tfl6ijkSfN8
	 aLSxCP9/VLjPbv3Az08ZQsUZw4AuQ9WJ59WIYRwyFULDQ4iPyKUFEzC1fxNvRUUYHOlwy
	 nOz4kXlxUaNqsUY6Td6irDbs0tffLbO9GqRdcl+XA9X+7po5t6Ch6eXd/T8R/irR5tfd4
	 f2m6ZQ81LqM2LUekUm64iPZ/ow7xIIhTyIz5MJnFpGzBRgmxn5Ruad/O537uDTCO8Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aoEchb89;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XY4SsWNC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAC606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aoEchb89;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XY4SsWNC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793793873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
	b=aoEchb89gvvb6h2u09uHbQU72owqh5kxOmPkmTEH9ylP7zLAbwzs3krGqPNc+dIK5x4khW
	Sbrxed6Q8Wl3ZolpkhTQEkEv/cofiEsvLCK1j4TP+osaa5IwhrOlRvBnYJ+1Y+vopLh5bv
	IivAk5LWjI8g4BsNtb4fDoPgoYLxGiw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-3atrnhZhOEC6KojdhGZpgg-1; Wed, 04 Nov 2026 07:04:31 -0500
X-MC-Unique: 3atrnhZhOEC6KojdhGZpgg-1
X-Mimecast-MFC-AGG-ID: 3atrnhZhOEC6KojdhGZpgg_1793793871
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b02d63407so588918f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793793870; x=1794398670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
        b=XY4SsWNCd/XyU4bYIRGZpysUegzvuvZjLZwC9/pkKxhwrQvlMsnFy1RNbVfp+sFKXf
         c0OGUwcXRMIFZ0LfYbkEHiGiEn930zYX1E6u5PRXkoViBsWCGQKrnEVgdawdALpC4gPo
         hqW+JhS4TmRElOr4HGCVNzELVq1D1Dtw44VTNT9DVaxzp7l20rkUqbTeefUXmiCb8FBy
         ig+m4gcVtIgasXfARf7/uF8n0l73dj7ImFfbN2BPSfYzs25EzNgu+tC6O8Iz2S4TJwPW
         CSFT0UkEFSbBQbL7MeF+5FrHHLxxIaqSfN95ZZYrZ1DkbGtuayqpPqR0RjoZf94GdPj+
         +/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793793870; x=1794398670;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUiJjgiBoxlCfwD7k2wmbIMBxvsfPqQZKBPmjCnOmAg=;
        b=k2oqtQPWmrJzqSpE7hOmpRrZ2yY4oHwJlJYb2u1Z2UhWL/t/i7FTh978fx8XS16/Z6
         DoWEvVWlXM5mbZj4GXuXU0oqsZme1rwb6ugwk4k2xW0Uf7A1q+C5hSx6e4Pm6qGSFJ05
         wzjtxpVwBxspA/dC7YR/xnew5JG1IChttbepcpBZYbN8ZzTXnU9mGR4GXqYBjTH8aTYA
         8QftQXBKLdTL9L2Qar7JIrIuLdChUuF2ZKfByE+lPC8MiFGG3U6oGiDvgqkE9ggh7EHV
         Iye8rmANSbTGfQV0tF//f0qhSuyNZmN+QX5EMUslDOCSZ2QEOXUbgCdCG/RkHd/b3tiB
         vmjQ==
X-Gm-Message-State: APuU4Z+oclOROoXZkCX+eYap1xrRjc8vuZ95KBUgF1YvTtLzQl7QFof2
	0IVqhfrz4jDRH1OoftXX4cD4AWN1vnicjaorcgeAEb71+fIEDsHCjUhRc5KoCyYzv2vVKO/tLIX
	CIEs6/pzAq2Ny5rac5WqkvBzWMA6Od1iED3dO7ZDapRzQ7Cj9ffhUg8F2CQ==
X-Gm-Gg: AYBFou3ap7Acn5kX+uSo5qMh0951/MdyypdfRPjz4RpJ8S+zWO/HyqLb3bLScyWFWdk
	0K17zC0nr+6MkQkvy+CRcCYdceN4w75bl/MMJN2o2WJ5hwn4fOpkMZdxeHVv1VYfTI2xc1cxUlQ
	3jONvaYXlnM+3TyvrjRM/218u8EBViAFEgICzS3PZyVYTADRzm6ea8mKDYkE4irgoO37GqsFtOO
	JBq68A4WAoNPvymu4lL2M82ZBZD/pWFGqEsHBKcqrotTIOaqRf+6Lx+1g41/BjaiNB+fMTk+3av
	o/AhwOHhvTCL6U0M1rjFjB6/4Aa6/DWPsAGqiQUHJ9w1Grz6W0W24iEkUQWIr4MrhxCJgdBFtbI
	xHy+yDJAJ69Z27yGgCnMNpDBppFZKF8uM4PiAzIo6ZA==
X-Received: by 2002:a05:6000:15ce:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48e6e2c155cmr25924779f8f.7.1793793870307;
        Wed, 04 Nov 2026 04:04:30 -0800 (PST)
X-Received: by 2002:a05:6000:15ce:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48e6e2c155cmr25924726f8f.7.1793793869640;
        Wed, 04 Nov 2026 04:04:29 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm2780896f8f.28.2026.11.04.04.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:04:28 -0800 (PST)
Date: Wed, 4 Nov 2026 07:04:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dongchenchen2@huawei.com, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH net] net: reject a negative TCP header offset in
 qdisc_pkt_len_segs_init()
Message-ID: <20261104070345-mutt-send-email-mst@kernel.org>
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>

On Sun, Nov 01, 2026 at 07:44:33PM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
> offset, in the unsigned hdr_len. A header in front of skb->data gives a
> negative offset. For an offset a little below zero, pskb_may_pull() gets a
> small length and succeeds. Then a 64-bit kernel reads the TCP header far
> after the skb and can crash. Further below zero pskb_may_pull() fails.
> 
> Commit 28a57fb2c5df ("net: iptunnel: fix stale transport header during
> tunnel decapsulation") fixed one source of such offsets. Other code that
> removes bytes from the front of a packet can leave the same stale header.
> 
> Return SKB_DROP_REASON_SKB_BAD_GSO for a negative offset in the TCP branch.
> SKB_GSO_UDP_L4 and the other GSO types read no header and still get a wrong
> qdisc_pkt_len(). On a 64-bit kernel only packets that cause the read after
> the skb today get a new result. Then __dev_queue_xmit() drops them and
> returns -EINVAL, but sch_handle_ingress() ignores the result. Their content
> can be valid. Thus the code that leaves the header stale needs its own fix.
> 
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and cc stable, maybe.


> ---
>  net/core/dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3ac700d37e59..ccf4b02e08de 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4320,7 +4320,9 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
>  	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
>  		const struct tcphdr *th;
>  
> -		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
> +		/* A header in front of skb->data gives a negative offset. */
> +		if ((int)hdr_len < 0 ||
> +		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
>  			return SKB_DROP_REASON_SKB_BAD_GSO;
>  
>  		th = (const struct tcphdr *)(skb->data + hdr_len);
> -- 
> 2.55.0
> 

