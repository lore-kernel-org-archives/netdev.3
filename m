Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640666;
	b=JmeHnoLOZ/sFImq86LDbFHJHvEBZFZa+wmZNYVL5jG87OdHLpsOVvDzYw3ccan8o+9DO
	 OTzhyRJr0MvzPBAkelI0AbKadCtTbRg9ya5vsoUxFVHKpB39BWNLa1xS8zbenZ00qI1x9
	 eN7DOt98NBI+zrSIYFn1mKqMf2rMvuff+BnjCJn1j8/hl11VXlOKAr0bp2KsyFz68QZR7
	 Q7OaXF2HrwSjA6Zai4JL58TZdnRNR5pCS4zxu2FZCW9Zopv7nl9PMvgxhTJSTe3LzqNZ1
	 jTvCudyROpA7ow2n/L/a+Hf/eWrz07YKMr4LEhO64qcikZDk7uvzjEJJ1yDkuNXd8og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640666;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
	b=CiiOYECuOACQaAqO9U7wP9WadPKPqBmE0OLlUK9S09UqQ0l8TtktZgDf9HnQ+HHvUH9i
	 8EZhV1SHzGAmh41VZ9tLzTlhApLqxUuLSUoxO++lIbs5B0UiKbZjLhItazkxTW++44oEA
	 XGZt7gx0QBvaLzQ33UwvDa7FpZApkPOv+EE1zEocSMckk8G28qUdLIqYlGx0PS1VkJlyM
	 B8QiUE/NxnD1Oe7SGCqCCqClhgrs1rrFDtSN0sO4o4fQIBwqebWwqCAFnk8XrCedLRKbF
	 kvmBnvTv3dryKwpgqDzFXMzU9977kG7xP3FErEV1mYdgFQGTLtKtyXQvCCU5IcP6bBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WO/weqq/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nDV52+Pg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668D606A595
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 17:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8668D606A595
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WO/weqq/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nDV52+Pg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793640664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
	b=WO/weqq/mBliiL5yMRKjE/qPlDM3IwxJfG5ikevaMuZ7pnw6yd6/1+jmTIh4GuunYICdEp
	8Eple4CV1QLH5zp1UeweuSzs5djw0Mt2uJjyWXcxt/kb/xD1gmLhtjMxM/N7wl0zKMaRtk
	q0IoPsf9XfbiqXfQKSJQCYlk6jDthRM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-5EzhO50qOHO73Hnxj45WhA-1; Mon, 02 Nov 2026 12:31:03 -0500
X-MC-Unique: 5EzhO50qOHO73Hnxj45WhA-1
X-Mimecast-MFC-AGG-ID: 5EzhO50qOHO73Hnxj45WhA_1793640662
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2063be13dso29504035e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793640662; x=1794245462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
        b=nDV52+Pg5PDNA7V1QVQKM2uUoSBEq5/BhVNKgQQJ0jEhyHgyBTW3BdAc6ZdiJsVv+M
         cJ382PbjYgAWqBRtjiDYCtAqHaV7ygbLyJSEZF9f+Zt7Yu7YNASwaXvmYwbqaFFZQHzh
         Hpg/v2K5MYoGB35N66S2kl5yIFgHuQBPtmtjd9hKeP/zAas5S1Now+bywd0l1DCHZOkE
         piikiCezukkgW16O2vEVHcn23DQQbyukWIFiTiqC7pqCxMYRxcapQb97oZcHEOxEcYbY
         V0BQI/tPYp8WuoQV4+DeSpaNDaxZxczCm/BfmpiEuqSVuarNGVNmF7ePo2Ffbwdb52bl
         TV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640662; x=1794245462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
        b=Y4zp2DaxEGqqEEhpO7PyfZmh2UdlJK6eV3Ha9g1VIH8zT3TumrVphX7LVXGbSTx/aW
         GvyVO+UsRmKj2ITK2IYQ/T3YM7IxbupczebX/1AgWTOg2URkbL2baLJMo71WCkTsGzp9
         kPa9f+5ozlEQfMarLRp0FioNIRMnxfkpVC4cLpYXZWTx+mW5ZpdHj57ttzNKBnTOZuHX
         yPDFi9V1r/DmgMEstpSrxbHCOD8kPcYmdRit3X9ihY09kmKYiSPVyVJ5bMeEvGasQ0PG
         Jekj6vg4dswe7+nSQZYJKLX6tYbEGUZ7eMxpsgWrXePzYf+QQ8lTx/nk3RKfe0EqdpH0
         QbGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuqGcS+g4b8LmWqkpak6kAE/riOj61wUtpOqqhSyVsVZcM1d0gcuDa0FpoKuFjbCMBcKIlZn8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGujQaTxl0kfwEReFqo20ZBK2Q3GZ5GkbTC4vk5AY9BaXP9+nZ
	lQXw4S500dRSPDU9eAhqa+mEfK3Rd9FV2WK7+wL0YiHcnqEQlYM5fw8LFWxqNe5ECD2ZyAc1e8U
	5SftKewscLg3pY8b/c4Uew1TNA9NzM7waAbPdZ8yaBY8XWdiLIMwvX3EhGA==
X-Gm-Gg: AYBFou2FF60KhU2/KAP5zzvzbQGURUs9iJ3Uw9qYUBeGitB/0FCIWY+a3fjAwCsXvMr
	N4wJQfxsMGYpcptkcXCxQzGyMNvZQUc2Hv2W69pCmKi0GRakHVqTdOYGYiuobP+QfZaucULHI4l
	eC/gTe2VelPgyuq/GDIl8PrekwyL841YFTh2fhPQtCsokhyP7/zvd8gyNwDWhgiRL54GLjV2UQm
	5Dz841GsYRT298jKyEQ3a7cv0WrA/50EJpBy9UC4vRwYA3II6N1faVXlmouYaCi9yZfcBLScJwT
	ZLGOdRxquAiyg4RVI/GRcUYVm/cfYTKlpkkg4CXi6w/MVwSV1iE/JN7qtk14zj9lFgDU7hgzqln
	YRvPVfr4eqJZ++1819OJF2OlA01mrBCRVwQRXKU5W7w==
X-Received: by 2002:a05:600c:310e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4ac1709ae70mr245615695e9.15.1793640662130;
        Mon, 02 Nov 2026 09:31:02 -0800 (PST)
X-Received: by 2002:a05:600c:310e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4ac1709ae70mr245615175e9.15.1793640661652;
        Mon, 02 Nov 2026 09:31:01 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa953d35sm1240835e9.9.2026.11.02.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:31:00 -0800 (PST)
Date: Mon, 2 Nov 2026 12:30:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lianjie Wang <karin0.zst@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
Message-ID: <20261102123049-mutt-send-email-mst@kernel.org>
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
 <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
 <auCkXHi6IulXgm7v@wang0.localdomain>
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
In-Reply-To: <auCkXHi6IulXgm7v@wang0.localdomain>

On Tue, Oct 27, 2026 at 10:53:16PM +0900, Lianjie Wang wrote:
> On Tue, Oct 27, 2026 at 01:06:41PM +0100, Paolo Abeni wrote:
> > On 10/22/26 20:26, Lianjie Wang wrote:
> > > [...]
> > > @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
> > >   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> > >   		hdr = p;
> > >   		qid = le16_to_cpu(hdr->vq_index);
> > > +		if ((qid < first_vq || qid > last_vq) &&
> > > +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> > > +			return -EINVAL;
> >
> > I think the above check could be simplified to:
> > 		if (qid < first_vq || qid > last_vq)
> > 			return -EINVAL;
> >
> > squashing the following in virtnet_get_hw_stats():
> >
> > -       if (enable_cvq)
> > +       if (enable_cvq) {
> >                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
> > +               last_vq++;
> > +       }
> >
> > (likely with some meaningful comment).
> 
> Thanks for the review!
> 
> I looked into this, and I think last_vq + 1 matches the control vq
> only when all queue pairs are in use. The control vq index is
> max_queue_pairs * 2, while last_vq is curr_queue_pairs * 2 - 1 for
> ethtool -S. After ethtool -L lowers the queue count, or when probe caps
> curr_queue_pairs at num_online_cpus(), last_vq + 1 is the receive vq at
> index curr_queue_pairs * 2, which is not in the request. The simplified
> check would accept a record for it. Since the ethtool -S array has
> slots for only curr_queue_pairs queue pairs, with the transmit slots at
> its end, virtnet_fill_stats() would write the counters of that record
> into the transmit slots, and can write past the end of the array.
> 
> Would you like me to keep the current check or change it in some
> other way?
> 
> As for the comment, I would add the following above the check in v2:
> 
> 		/* The control vq comes after all max_queue_pairs pairs, so it
> 		 * exceeds last_vq + 1 when fewer pairs are in use.
> 		 */

didn't get v2 yet.

> 
> Thanks,
> Lianjie Wang

