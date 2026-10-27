Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109202;
	b=ShSVAZLTpUj7ISorKFPzl2ueDwy8IgsQn4i5pzp0vUYq8iADWH45vh0zlhrzZEzcvhiV
	 odBpXrSNL1ZOkai4fn2xfml8ESZpo6+a5k6ewpvkEK6jhMCSnb1OUX9RtUmsFbk2S4Gnm
	 zPz7qVDT/VzCaOporiNilcme+w0VjGiA/it9ryREqs4qcwcOb92OrrPaCXRTdAFkRuaYy
	 ns2SN6b0Jeu3Zc7nVvdysw9Ps04q9pOF+NExqTqxPlD4gjt+17gVO5sI6Y3y/TDcmkLLO
	 5asoC7b+ykHN8LFE58Lb8NTSSjf4fVIXTjgj5fJnE+I9X8K2PmX2VQH+N2C0wDxLflA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
	b=unQOWUI1YQ/2CQFUv/uSWKhwRWzQiWLJ1rnRHF5BEu8VDQg8T0n2EQgGh0ioEmW9HNFE
	 UO6PUE8cF2t4nfSSQX7GTskNeQwTCrMs2udqA51v2Vp9//qOO8wuVMDv63BL+1KmM/coS
	 mk5KTIi2L8F3hVb4xkjVBNAxRyDT93IgNETOy2fItA9XO6TVaDILdHgmxy8rxH2UUNGOU
	 mznj1FlMIR6ETmF4kJ1ij1QkRQtifgThR+4OQIeApdCcqsdqHhXVpVIC3E1XVaKGBT1ak
	 d9W3/hQT1Q7VA9el/BLO9Lk9Oh13SxG3K2yIcL1rgfx5azPexUcGPgl98bHuLfM/+kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ao/YHcb0";
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D6606A33C
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E1D6606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ao/YHcb0
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc7c286026aso1658852a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793109200; x=1793714000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
        b=ao/YHcb0a9EZt2JZ0Jw43sww0NwPRYR9JMmJw1T10j5LNFrQXEBicgmlxBSANOKCg+
         /XTzCfSG6FkkshfhKJjgOm+6/i8qfeB13uF80OHWQmN70t8gBUzKAJ5ZUbehP6EqBPH3
         3MHBwG+3gclSvnpjCid/OXjbXF/R2qgkdySo1CrVILv/4zVG7T4SFPWxCifPlYWhyf9R
         FKOjZlQbuXOYQ3O1RcnHjr/cE9FM8Xn5PcaMAbNG89Rzjs8ylNX7UXqxWELflCPDKe3N
         WBrLE+r2H6F+rfJUAUoBYFHAf6fN1fZN3BrBfkYQ/4VwK/wiCEd1ywrCj3YOGn9ieoXj
         KN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109200; x=1793714000;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
        b=No02Kmn2al3/E5zDfbfiswOPL5Ub8xp/Nv70nM6AN1+vGRaoItsXXDXQO1DNssAJKd
         6faRjYLFs3LFyayyqk/+BZG1zChWLkbWclWOiFVb74OBQxmLLcMyjpX4/ZpLVxNd4uiX
         BL3n5sx1/TxpNttGT8LeldWo86JMx3IA4flcxpQZ7cyJ1euH/bLQErzXQJpQzcCsVpfv
         U26ehP8+vp6XQRpp0MzHMuQLAcfiAl1bUu6Yl+TuKnjcaSS0szL8jTz6we3pYLNR2Fyz
         MNJLq7DSJOiW7Wr0es4atCZ0dcxnI+Le0gXmi6AEYQRMSX2nF7kiFl04W8UGyKFe8XQx
         p+8g==
X-Forwarded-Encrypted: i=1; AKwUvBwrFa9e9sKttCZFA9bi4r+yz15WBHAK0HPL/zaFELdEo1kOUmIlQySwz5+EYoWxjljqeSZAejk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJe7dqY+PJGh3HwltVT0xUoyCyvbARifxIjS5RcPYHCSifdrhqm
	nTupOm6Z6Plxvpo0be+YFEq6fYRyg+H5JncEEwTZOki6nffZa/4Q7ffv
X-Gm-Gg: AYBFou0YwLIUWom4Ah5c5AOZn0e7kXgixujI1yOny+AffkirF2evsbHJzLG/8vkxjYI
	hCOkOgezNXR3mfws9x0sDiqZu557WfJV5pTilt5l6UNhdr1z3ySWMcHD7/IfUT0jkXzUjU01mUV
	hecTreFSDtRsfvRQ+hVw4Xe6bFQJc+f58LeS3XMs++Y7dGTwBfB14TBucTQyFswXd7UGGsXr0xL
	+ivMbX3tFJ5yGwkWKagWU09t+99g0Xa9BT7HUCvuR0qeDvK3ireg3kw32Oue4AqLXP4IeNzX/AM
	Tm7xTdCMnFjcuJd6tZ5+3NEQqAQxIDay4cHSf7cvLrpD7oKlA4tW6SCo8kauhJ6VvFwww6eO4YR
	HEq/apMB9k4qGGPnhCpgoCfPdP/5KVMIcUrNfLIerlOW79F018/qQ6fd+svJCiyOuZVUBR9L6Aj
	AzQqvqdzyEtMqqqiIy6CUfuuAs4Txv/Yaf1H6QbwCenDBxMo5Cr9NsL37IiICOy1VZAOoNHP1/t
	7MQN1K4lVCWXRhHCbnwUFkOf7hycfeH1yisNaH0F1STPUP+m8x3zVmypaKW0WgsC5mq5cEAWVQb
	oZUbQSQAlhrO+UTVKQpGnjdyWw0bnbc4TNKqg7Q9M+Ta/l3V7zjv5GOnx84reem/hDkrZSXlq1M
	lKykdzJZce9nw8Jojhd95kEl6ED4MXz8vi2QPxlSpolDe0WZe5v+EOTzjn79xidwTLrSl2tsUmA
	J9
X-Received: by 2002:a05:6a00:3a17:b0:89e:779b:cff with SMTP id d2e1a72fcca58-8a364b4ce5fmr8249181b3a.6.1793109200511;
        Tue, 27 Oct 2026 06:53:20 -0700 (PDT)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a5f652aasm50188b3a.17.2026.10.27.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:19 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:53:16 +0900
From: Lianjie Wang <karin0.zst@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
Message-ID: <auCkXHi6IulXgm7v@wang0.localdomain>
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
 <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>

On Tue, Oct 27, 2026 at 01:06:41PM +0100, Paolo Abeni wrote:
> On 10/22/26 20:26, Lianjie Wang wrote:
> > [...]
> > @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
> >   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> >   		hdr = p;
> >   		qid = le16_to_cpu(hdr->vq_index);
> > +		if ((qid < first_vq || qid > last_vq) &&
> > +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> > +			return -EINVAL;
>
> I think the above check could be simplified to:
> 		if (qid < first_vq || qid > last_vq)
> 			return -EINVAL;
>
> squashing the following in virtnet_get_hw_stats():
>
> -       if (enable_cvq)
> +       if (enable_cvq) {
>                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
> +               last_vq++;
> +       }
>
> (likely with some meaningful comment).

Thanks for the review!

I looked into this, and I think last_vq + 1 matches the control vq
only when all queue pairs are in use. The control vq index is
max_queue_pairs * 2, while last_vq is curr_queue_pairs * 2 - 1 for
ethtool -S. After ethtool -L lowers the queue count, or when probe caps
curr_queue_pairs at num_online_cpus(), last_vq + 1 is the receive vq at
index curr_queue_pairs * 2, which is not in the request. The simplified
check would accept a record for it. Since the ethtool -S array has
slots for only curr_queue_pairs queue pairs, with the transmit slots at
its end, virtnet_fill_stats() would write the counters of that record
into the transmit slots, and can write past the end of the array.

Would you like me to keep the current check or change it in some
other way?

As for the comment, I would add the following above the check in v2:

		/* The control vq comes after all max_queue_pairs pairs, so it
		 * exceeds last_vq + 1 when fewer pairs are in use.
		 */

Thanks,
Lianjie Wang
