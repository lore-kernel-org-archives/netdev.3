Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5E47D45B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143196; cv=none; b=SB2hnyQbcEiqMfFFXUg6FYRNjjg6Hojsax2bRq62FLG2iy8DJ8NwDwaY4T7m9Mu6F7J3+3GYCXbVXOa0lIJNIsAdeb04YtS3mFthiaO8opyg30DGehohy/lo8UzKJ8/Fm0+1Q6KX0593uqpSNYiVPakIB4/f2BhA/J8vnbOYdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143196; c=relaxed/simple;
	bh=O/OiA4BQPUKLUXonJsE5pdtPrknSunNzaSfCvLDOogo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsuo8ULLyb13xkJk5QrmpgDIe5se24l2MJbHjpOK/Rya0JrmVs3a/l2dtTyzOJy55RRsnnHoyCuWe/yhiSdHOibxfvuWxlc7n3eGbiQUXN2wG826KIitjrdEf5r9A4n+a2anm/7Gf25hvkDpvF/XxiGS202XsBKO9W2xP5t33ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AM3nYNW6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1ydN9P6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM3nYNW6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1ydN9P6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1WIlfJD+ulbctbVceU+ouilxpQA89DiQidLIlC9D0g=;
	b=AM3nYNW6DdV4sLxY3CPMCibgsaUUcnEaJr838VbRYWooywOAc9W2riMWm0uYP/QNUdsiS9
	UROl6aHd0q36spBJY7jDeL7QhfAI7+Tkwf+nYH+kpt1rp9sTlmvJrfyBMb58I7AxG9IbaT
	2ghXsttvD2VRv0XqZYJQIp9NpUnkrug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Aio03SHgPaaMi2PZWfdwZg-1; Fri, 16 Oct 2026 09:33:09 +0000
X-MC-Unique: Aio03SHgPaaMi2PZWfdwZg-1
X-Mimecast-MFC-AGG-ID: Aio03SHgPaaMi2PZWfdwZg_1792143188
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso5674975e9.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792143188; x=1792747988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F1WIlfJD+ulbctbVceU+ouilxpQA89DiQidLIlC9D0g=;
        b=N1ydN9P6jLCmdDDkPrFUc99czMW1fGI89cmkgFqItRS830Tj1gH/9haAuXopUzLd/g
         ojf9cj63SI2Hn0u0l+9+dkKAmqU5x7CqxhhXb8auls1inzCAMN40dFUJkVqLiCykg106
         EyqqdmDFdN5jo7hFTCuz8nQcSyShwXwHK6i1wR7iFzqO7e+vidlS4pymB3S28lNcRH8u
         7FtMR5sqpeyvFXs2lgYezdZ0h9SADSRIbsk/JE9SB8MvFgNsMpH7jrOyFYFlJaAybwWQ
         vtJNRZaNUIrw59/W/W0CtP7cPevLjTUcjpGYNqezScXdzgNXkWLDcZgdg/nKWZq83gpX
         zPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143188; x=1792747988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1WIlfJD+ulbctbVceU+ouilxpQA89DiQidLIlC9D0g=;
        b=TTuHjetv2jkxS6Mb7/symZrb/fz/9vX3jOOrF3aSySlJnhsnrmJDeSTmflthjyH5N3
         C9ELwr3EzVoB8HuEtKa1wquFqvEZmjczbFBl9piG0W7th8j2yvLd2qSBjpH8+uvZiwCM
         kef1a+u1a+UaMD6UDuZB1y8AsHjvgONJJtgtJyh3kdd6XwB965QixI7k966Lbav+EEOW
         +AxvCGA8cR+EicTU0YlepfFul3eO2+QXMKVlVlfAEz5cRAhyAhzXmnfAvIyfRgK6mfWB
         lthBh7uPWV/LNl+7DH/zmexPjDozzRjIyZeYxvvzMKZFVSiUJJWmb1laHBykclCY02oQ
         NlVw==
X-Forwarded-Encrypted: i=1; AKwUvByYAABv4YeUJ8PQY9kWj3tMEYitidI+lp1huZB+CFBu+CfzWRmaUlsGPb85r2QffiUywZEYdxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKXWck/52SXVGrPsOaof1rXNF6ERm/HK3nx/vDe45vY3IMTcg+
	JpE/cas5nOz5GrXhocHvxCoEREsKVvlu3doix7BYBAVMwGn4P4A198RwmrvN8faoKMnJS/6dGB+
	ZZZ2zSh7Y88qJizMwNjDz0hDESkg/pkVeFRFU9hYd9ovjhTEqNSluEOVnHg==
X-Gm-Gg: AYBFou2yx+b1f/ZD2VGr9iFODCg0wnufUZ4xrH38gQ/4bMooMWkSdv1NdvchzJRCt1j
	irCTuaASiJh/4SeR3W3owYGOCY9tM1eO+p1LHkMscoPmGDlGkQ6dEoETFYayt0da4wkHwxz2JT9
	o4IVla+5YjNz20yqnS8wWpC7MDSna8Qo7gOFd981uWuOZ6eYumOk5xvQpCWKzDAC1lLfLh+OU8z
	QSyvqsqtpBDc/nZXODgFxcMOpTm9XV/of5dbtM07N7J+TWeIUp84HKiUq5YiY890ltHqeyXwRgO
	FuTEnwZKoxAl77W/rnWgDa6fw3wfp78dmvvDqbSHL+5fXxx+jh9H+sDpWJi1hw6rKtBQ9w==
X-Received: by 2002:a05:600c:c0d4:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a1c664db70mr51292395e9.6.1792143188191;
        Fri, 16 Oct 2026 02:33:08 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d4:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a1c664db70mr51291755e9.6.1792143187537;
        Fri, 16 Oct 2026 02:33:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm44682945e9.6.2026.10.16.02.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:33:06 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:33:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Message-ID: <20261016051827-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>

On Thu, Oct 15, 2026 at 01:50:54PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > The ingress validation as implemented by the previous
> > patch is stricter than what it replaced: GSO
> > packets whose checksum metadata matches no transport header are
> > dropped, and non-GSO ones get their checksum completed in place.
> > Such packets used to pass with the metadata unvalidated,
> > and with no overhead.
> > 
> > I judge that this should not affect any deployments, but there is still
> > some risk that it does.  In case a deployment depends on them anyway,
> > provide a per-netns switch to get the old behavior back:
> > 
> > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > 
> > The default is validating.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
> >  include/linux/virtio_net.h               | 23 ++++++++++
> >  include/net/netns/core.h                 |  1 +
> >  net/core/dev.c                           |  6 +++
> >  net/core/net_namespace.c                 |  1 +
> >  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
> >  6 files changed, 100 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index e586e17fc7a5..7f230929c37e 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> >  Default: 1 (on)
> >  
> >  
> > +virtio_net_hdr_csum_check
> > +-------------------------
> 
> Make more generic, virtio_net_hdr_validate?
> 
> In case we add more validation in the future (as we have in the past),
> without having to introduce multiple such knobs.

But it's uapi, are you sure we'll be able to change the meaning
of an existing knob, even if we keep the name vague?

> > +
> > +When processing packets with a virtio net header (through tun, tap, a
> > +packet socket or a virtio network device) that request checksum offload
> > +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> > +in software, or drop the packet where the header does not match it.
> > +
> > +When disabled, the header is trusted not to corrupt the packet, and the
> > +checksum is offloaded to hardware (or not verified if it never reaches
> > +hardware). This is only safe if no protocol is processing the packets.
> > +
> > +Default: 1 (on)
> > +
> > +
> >  wmem_default
> >  ------------
> >  
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 357115ff0ec2..aa2f8ac4657c 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/if_vlan.h>
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> > +#include <linux/jump_label.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/udp.h>
> >  #include <net/gso.h>
> > @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> >  	*thoff = nhoff + iph->ihl * sizeof(u32);
> >  	return iph;
> >  }
> > +/* Defined in net/core/dev.c, enabled while any network namespace
> > + * has net.core.virtio_net_hdr_csum_check set to 0.
> > + */
> 
> Should this be a global sysctl, rather than per netns?


For customers I work with, it would be much less useful.


> Even if per-netns, most likely do not want it writable by netns root
> with user namespaces.
>
> That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> of many crashes due to bad packets ingested by, e.g., a packet socket.

Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
on by default?

> A global sysctl also allows using proc_do_static_key and avoids the
> custom logic in virtio_net_hdr_csum_check_sysctl.
> 
> >  /* Where does the L3 header start, and what protocol is it?
> >   * Handles Ethernet and VLAN headers; other devices use the
> > @@ -152,6 +166,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
> >  	unsigned int thoff;
> >  	int ip_proto;
> >  
> > +	/* Failsafe: a namespace opted out of the validation,
> > +	 * trust the checksum metadata as before.
> > +	 */
> 
> nit: as before, imho the code here is clear and comment unnecessary.


Ugh. One of these got through. Absolutely.

> > +	if (virtio_net_hdr_csum_check_disabled(skb))
> > +		return true;
> > +
> >  	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> >  		return false;
> >  
> > @@ -483,6 +503,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> >  	unsigned int thoff;
> >  	int ip_proto;
> >  
> > +	if (virtio_net_hdr_csum_check_disabled(skb))
> > +		return true;
> > +
> >  	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> >  		return false;
> >  	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> 
> > +/* Defined in net/core/dev.c, declared for the gate in
> > + * include/linux/virtio_net.h.
> > + */
> > +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> > +
> > +/*
> > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> > + */
> > +static DEFINE_MUTEX(virtio_net_hdr_csum_check_mutex);
> > +
> > +static int virtio_net_hdr_csum_check_sysctl(const struct ctl_table *table,
> > +					    int write, void *buffer,
> > +					    size_t *lenp, loff_t *ppos)
> > +{
> > +	struct net *net = (struct net *)table->data;
> > +	/* checkpatch warns but this can't be const: tmp.data is set below */
> > +	struct ctl_table tmp = *table;
> > +	u8 old;
> > +	int ret;
> > +
> > +	/*
> > +	 * Make sure virtio_net_hdr_csum_check_disabled_key counts zero values of
> > +	 * net->core.sysctl_virtio_net_hdr_csum_check.
> > +	 */
> > +	mutex_lock(&virtio_net_hdr_csum_check_mutex);
> > +
> > +	old = net->core.sysctl_virtio_net_hdr_csum_check;
> > +	tmp.data = &net->core.sysctl_virtio_net_hdr_csum_check;
> > +	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
> > +	if (write && !ret && old != net->core.sysctl_virtio_net_hdr_csum_check) {
> > +		if (net->core.sysctl_virtio_net_hdr_csum_check)
> > +			static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
> > +		else
> > +			static_branch_inc(&virtio_net_hdr_csum_check_disabled_key);
> > +	}
> > +
> > +	mutex_unlock(&virtio_net_hdr_csum_check_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct ctl_table netns_core_table[] = {
> >  #if IS_ENABLED(CONFIG_RPS)
> >  	{
> > @@ -737,6 +780,15 @@ static const struct ctl_table netns_core_table[] = {
> >  		.extra1		= SYSCTL_ZERO,
> >  		.extra2		= SYSCTL_ONE
> >  	},
> > +	{
> > +		.procname	= "virtio_net_hdr_csum_check",
> > +		.data		= &init_net,
> > +		.maxlen		= sizeof(u8),
> > +		.mode		= 0644,
> > +		.proc_handler	= virtio_net_hdr_csum_check_sysctl,
> > +		.extra1		= SYSCTL_ZERO,
> > +		.extra2		= SYSCTL_ONE
> > +	},
> >  	/* sysctl_core_net_init() will set the values after this
> >  	 * to readonly in network namespaces
> >  	 */
> > @@ -841,6 +893,8 @@ static __net_exit void sysctl_core_net_exit(struct net *net)
> >  	tbl = net->core.sysctl_hdr->ctl_table_arg;
> >  	unregister_net_sysctl_table(net->core.sysctl_hdr);
> >  	BUG_ON(tbl == netns_core_table);
> > +	if (!net->core.sysctl_virtio_net_hdr_csum_check)
> > +		static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
> >  #if IS_ENABLED(CONFIG_RPS)
> >  	kfree(net->core.rps_default_mask);
> >  #endif
> > -- 
> > MST
> > 
> 

