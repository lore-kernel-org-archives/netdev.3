Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3423947B5
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845459; cv=none; b=rEulfiH/YmATYBwUVfwvKrkE/W3zBupfQf9nFALYVT9gBn4ICl2Q1railT+Xk5Qx+ynUt8b9tHbiGbhSpLR8pimyRPn4HeTtKJ1B+xS2Api4omKn0lUgigTjnM5VAU638RKsepAPpvNFNWLXZp0PPfAM51g1MiPHntPxpQO2RJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845459; c=relaxed/simple;
	bh=1EQvzPGMyqpJuII4kaRuUqI6VnnZj46dd+1O4QxQaKw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kb1kfFeVaU0zufwKUHAjfNDiS3QNBJOIErTYl2y454FjJ6P1WabVf5/dLclabh7GrA9dXi0ew7nFwmbZ9kRgFRIrqDSwaEXl730Yb9EEU/6ZFxqTnjLxg2cF3cTlNPaBJw/sFIghXQD+PAn/mtuOago0G7ac+vhIAWtKau8/0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogic29mV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogic29mV"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso733527a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785845456; x=1786450256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jpvi0BnyOkq/qAzgljr9I9fVdjuH3hVIHM/z5PjM4vo=;
        b=Ogic29mVUKRM+3Y6n7/mCV+gkd1TDE0TnKMPS1SbrPJhWMybvZzxo6lV3k29YD5nBg
         6+vyoPUQ9rDpSqYNITd///mal6oIEQut0aHA5JzUEuCW+7MBYShPJpbmx5IJgmPESUae
         h+yZf41b0h9bOfhzH2/QRKcoLFsPb8JOTXLjG6vrvBJTzsB6GZ2utR/O9o4gldiZuCMD
         56IEtclMyHnxSR0h5wQ5BPMba8n2J0+bl7C4Vl8vbp0+jzUi/rWbfI8XbzLRKDe9C+TV
         GoYRNl118dD632Cr2Br9jW/jxhd8XNto7Jp+22qbY9fc59LVtndTE2IaOwhEg5yq+V43
         LhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845456; x=1786450256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jpvi0BnyOkq/qAzgljr9I9fVdjuH3hVIHM/z5PjM4vo=;
        b=BFN1Xl44Xttq6pp81oLvesDDvOkcSyb/TefYrwrLq4n/iEr6iDhaPUjiWpFiA3rUpj
         42wA4PpbsHonZ1fMRWnfGHqXdZfEXr5KTKF6BM8zxEmGHIw6E/ThjNL6LK8SQB3NvJDM
         cLrjOtPDcWi4lI0TBs1jMSY/L+HV4SMkXkGQoigiK8tYv1aZKmDQ7v3m76J4c58TwBIY
         JQ95S8FcP4FmhuvCnR/hc7TQtSnKf5e7tJZzXRV4VuDtcgpOxhqFY9OCSPY0aEdSDZ/A
         AjoHQ8wC4QUHp4mGc15SLgf0KM/mJUekquyRXvOgBvnzdUlhXSNyx3lbSjM5EoWCOfOY
         b+yw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6RVq3aQmwOjvWZRbXJ5D/D8XtpzEX814/2Jjbk/a+t+41NypvEq0tTYxwbivpI9vTXWK0uGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtu5H/OJGl/XFKWjlewVxVaGBhYP+pbVQQqPEtS3OzS3+BsRk
	G6z1OIhl7Egpfhz9fYxYDos3rMuOhKDcahYL9Jbr5FEneh2l8t3Ivzt3
X-Gm-Gg: AR+sD12A+dw6Qp2FMB/Hd0xKGesww2+YBJlmX7/+XJKMtc3/y2lXUQBbAknVwm52e6H
	y48ri19mpy/duCl9qn8fh87Ag9swtn0aDoEEh3OaZkBh4ERGxtwbCYFATVlC2HMXt05NCD9g/4V
	hZ6ZG9P0PdhCn9sWp1jRZcGTvpSAM41DB2ixqcIOdjQJSjZFk0ZPyRQWrST64zf6v3S4uF73OBs
	CmGpQvLUhhqCnaB639Id30EIybAhw73iR22Q2UrAlBaZs89rlowU5aGqCdk0rBP6BFJ7FzjudUq
	fUjm63avmzN198UDH0pvTW8G6iBXPGcSNW2MbcJENvRW8JgEOGqNAxHsRaMIJ4asDf06lnK2KTp
	r7+vmA4RSy8hqHRAH1FFqp9+hVU+G7Hw2c2VgScVZvORXPBaP6uY6vEB8LD5A6Tzwnqm1YmxZ+y
	M9FPRXYtnV1AacFFh4chLVUqYQ0nH434PwQZac8HLzl6E8HpEWOEZh8A==
X-Received: by 2002:a17:90b:2516:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-38fec15f252mr1739139a91.10.1785845455766;
        Tue, 04 Aug 2026 05:10:55 -0700 (PDT)
Received: from localhost ([172.216.252.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfd9155sm1287366a91.3.2026.08.04.05.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:10:55 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:07:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Zihan Xi <zihanx@nebusec.ai>,
	netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	kerneljasonxing@gmail.com, kuniyu@google.com, bjorn@kernel.org,
	bigeasy@linutronix.de, jiayuan.chen@linux.dev, willemb@google.com,
	jlayton@kernel.org, gustavoars@kernel.org,
	michael.bommarito@gmail.com, runyu.xiao@seu.edu.cn, kees@kernel.org,
	lirongqing@baidu.com, vega@nebusec.ai, zihanx@nebusec.ai
Subject: Re: [PATCH net 1/1] net: skbuff: reject skb header offset updates
 that truncate
Message-ID: <202607310427.nc6P5oqS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ac032651d91cfe4b2e246f6fc36e3d4b2f87d1.1785346409.git.zihanx@nebusec.ai>

Hi Zihan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Zihan-Xi/net-skbuff-reject-skb-header-offset-updates-that-truncate/20260730-175139
base:   net/main
patch link:    https://lore.kernel.org/r/06ac032651d91cfe4b2e246f6fc36e3d4b2f87d1.1785346409.git.zihanx%40nebusec.ai
patch subject: [PATCH net 1/1] net: skbuff: reject skb header offset updates that truncate
config: i386-randconfig-141-20260730 (https://download.01.org/0day-ci/archive/20260731/202607310427.nc6P5oqS-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202607310427.nc6P5oqS-lkp@intel.com/

New smatch warnings:
net/core/skbuff.c:5208 skb_segment() warn: passing zero to 'ERR_PTR'

vim +/ERR_PTR +5208 net/core/skbuff.c

df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4855  struct sk_buff *skb_segment(struct sk_buff *head_skb,
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4856  			    netdev_features_t features)
f4c50d990dcf11a Herbert Xu               2006-06-22  4857  {
f4c50d990dcf11a Herbert Xu               2006-06-22  4858  	struct sk_buff *segs = NULL;
f4c50d990dcf11a Herbert Xu               2006-06-22  4859  	struct sk_buff *tail = NULL;
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  4860  	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4861  	unsigned int mss = skb_shinfo(head_skb)->gso_size;
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4862  	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
f4c50d990dcf11a Herbert Xu               2006-06-22  4863  	unsigned int offset = doffset;
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4864  	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
802ab55adc39a06 Alexander Duyck          2016-04-10  4865  	unsigned int partial_segs = 0;
f4c50d990dcf11a Herbert Xu               2006-06-22  4866  	unsigned int headroom;
802ab55adc39a06 Alexander Duyck          2016-04-10  4867  	unsigned int len = head_skb->len;
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4868  	struct sk_buff *frag_skb;
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4869  	skb_frag_t *frag;
ec5f06156423889 Pravin B Shelar          2013-03-07  4870  	__be16 proto;
36c983824b6f17b Alexander Duyck          2016-05-02  4871  	bool csum, sg;
f4c50d990dcf11a Herbert Xu               2006-06-22  4872  	int err = -ENOMEM;

This is set to -ENOMEM but it doesn't work

f4c50d990dcf11a Herbert Xu               2006-06-22  4873  	int i = 0;
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4874  	int nfrags, pos;
f4c50d990dcf11a Herbert Xu               2006-06-22  4875  
9e4b7a99a03aefd Jiri Benc                2022-11-02  4876  	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
9e4b7a99a03aefd Jiri Benc                2022-11-02  4877  	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
9e4b7a99a03aefd Jiri Benc                2022-11-02  4878  		struct sk_buff *check_skb;
9e4b7a99a03aefd Jiri Benc                2022-11-02  4879  
9e4b7a99a03aefd Jiri Benc                2022-11-02  4880  		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
9e4b7a99a03aefd Jiri Benc                2022-11-02  4881  			if (skb_headlen(check_skb) && !check_skb->head_frag) {
9e4b7a99a03aefd Jiri Benc                2022-11-02  4882  				/* gso_size is untrusted, and we have a frag_list with
9e4b7a99a03aefd Jiri Benc                2022-11-02  4883  				 * a linear non head_frag item.
3dcbdb134f32984 Shmulik Ladkani          2019-09-06  4884  				 *
9e4b7a99a03aefd Jiri Benc                2022-11-02  4885  				 * If head_skb's headlen does not fit requested gso_size,
9e4b7a99a03aefd Jiri Benc                2022-11-02  4886  				 * it means that the frag_list members do NOT terminate
9e4b7a99a03aefd Jiri Benc                2022-11-02  4887  				 * on exact gso_size boundaries. Hence we cannot perform
9e4b7a99a03aefd Jiri Benc                2022-11-02  4888  				 * skb_frag_t page sharing. Therefore we must fallback to
9e4b7a99a03aefd Jiri Benc                2022-11-02  4889  				 * copying the frag_list skbs; we do so by disabling SG.
3dcbdb134f32984 Shmulik Ladkani          2019-09-06  4890  				 */
3dcbdb134f32984 Shmulik Ladkani          2019-09-06  4891  				features &= ~NETIF_F_SG;
9e4b7a99a03aefd Jiri Benc                2022-11-02  4892  				break;
9e4b7a99a03aefd Jiri Benc                2022-11-02  4893  			}
9e4b7a99a03aefd Jiri Benc                2022-11-02  4894  		}
3dcbdb134f32984 Shmulik Ladkani          2019-09-06  4895  	}
3dcbdb134f32984 Shmulik Ladkani          2019-09-06  4896  
5882a07c72093dc Wei-Chun Chao            2014-06-08  4897  	__skb_push(head_skb, doffset);
2f631133c40cd8e Miaohe Lin               2020-08-01  4898  	proto = skb_network_protocol(head_skb, NULL);
ec5f06156423889 Pravin B Shelar          2013-03-07  4899  	if (unlikely(!proto))
ec5f06156423889 Pravin B Shelar          2013-03-07  4900  		return ERR_PTR(-EINVAL);
ec5f06156423889 Pravin B Shelar          2013-03-07  4901  
36c983824b6f17b Alexander Duyck          2016-05-02  4902  	sg = !!(features & NETIF_F_SG);
f245d079c1d11dc Alexander Duyck          2016-02-05  4903  	csum = !!can_checksum_protocol(features, proto);
7e2b10c1e52ca37 Tom Herbert              2014-06-04  4904  
07b26c9454a2a19 Steffen Klassert         2016-09-19  4905  	if (sg && csum && (mss != GSO_BY_FRAGS))  {
07b26c9454a2a19 Steffen Klassert         2016-09-19  4906  		if (!(features & NETIF_F_GSO_PARTIAL)) {
07b26c9454a2a19 Steffen Klassert         2016-09-19  4907  			struct sk_buff *iter;
43170c4e0ba709c Ilan Tayari              2017-04-19  4908  			unsigned int frag_len;
07b26c9454a2a19 Steffen Klassert         2016-09-19  4909  
07b26c9454a2a19 Steffen Klassert         2016-09-19  4910  			if (!list_skb ||
07b26c9454a2a19 Steffen Klassert         2016-09-19  4911  			    !net_gso_ok(features, skb_shinfo(head_skb)->gso_type))
07b26c9454a2a19 Steffen Klassert         2016-09-19  4912  				goto normal;
07b26c9454a2a19 Steffen Klassert         2016-09-19  4913  
43170c4e0ba709c Ilan Tayari              2017-04-19  4914  			/* If we get here then all the required
43170c4e0ba709c Ilan Tayari              2017-04-19  4915  			 * GSO features except frag_list are supported.
43170c4e0ba709c Ilan Tayari              2017-04-19  4916  			 * Try to split the SKB to multiple GSO SKBs
43170c4e0ba709c Ilan Tayari              2017-04-19  4917  			 * with no frag_list.
43170c4e0ba709c Ilan Tayari              2017-04-19  4918  			 * Currently we can do that only when the buffers don't
43170c4e0ba709c Ilan Tayari              2017-04-19  4919  			 * have a linear part and all the buffers except
43170c4e0ba709c Ilan Tayari              2017-04-19  4920  			 * the last are of the same length.
07b26c9454a2a19 Steffen Klassert         2016-09-19  4921  			 */
43170c4e0ba709c Ilan Tayari              2017-04-19  4922  			frag_len = list_skb->len;
07b26c9454a2a19 Steffen Klassert         2016-09-19  4923  			skb_walk_frags(head_skb, iter) {
43170c4e0ba709c Ilan Tayari              2017-04-19  4924  				if (frag_len != iter->len && iter->next)
43170c4e0ba709c Ilan Tayari              2017-04-19  4925  					goto normal;
eaffadbbb3f2711 Ilan Tayari              2017-04-08  4926  				if (skb_headlen(iter) && !iter->head_frag)
07b26c9454a2a19 Steffen Klassert         2016-09-19  4927  					goto normal;
07b26c9454a2a19 Steffen Klassert         2016-09-19  4928  
07b26c9454a2a19 Steffen Klassert         2016-09-19  4929  				len -= iter->len;
07b26c9454a2a19 Steffen Klassert         2016-09-19  4930  			}
43170c4e0ba709c Ilan Tayari              2017-04-19  4931  
43170c4e0ba709c Ilan Tayari              2017-04-19  4932  			if (len != frag_len)
43170c4e0ba709c Ilan Tayari              2017-04-19  4933  				goto normal;
07b26c9454a2a19 Steffen Klassert         2016-09-19  4934  		}
07b26c9454a2a19 Steffen Klassert         2016-09-19  4935  
802ab55adc39a06 Alexander Duyck          2016-04-10  4936  		/* GSO partial only requires that we trim off any excess that
802ab55adc39a06 Alexander Duyck          2016-04-10  4937  		 * doesn't fit into an MSS sized block, so take care of that
802ab55adc39a06 Alexander Duyck          2016-04-10  4938  		 * now.
23d05d563b7e7b0 Eric Dumazet             2023-12-12  4939  		 * Cap len to not accidentally hit GSO_BY_FRAGS.
802ab55adc39a06 Alexander Duyck          2016-04-10  4940  		 */
23d05d563b7e7b0 Eric Dumazet             2023-12-12  4941  		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
d7fb5a80492169c Alexander Duyck          2016-05-02  4942  		if (partial_segs > 1)
802ab55adc39a06 Alexander Duyck          2016-04-10  4943  			mss *= partial_segs;
d7fb5a80492169c Alexander Duyck          2016-05-02  4944  		else
d7fb5a80492169c Alexander Duyck          2016-05-02  4945  			partial_segs = 0;
802ab55adc39a06 Alexander Duyck          2016-04-10  4946  	}
802ab55adc39a06 Alexander Duyck          2016-04-10  4947  
07b26c9454a2a19 Steffen Klassert         2016-09-19  4948  normal:
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4949  	headroom = skb_headroom(head_skb);
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4950  	pos = skb_headlen(head_skb);
f4c50d990dcf11a Herbert Xu               2006-06-22  4951  
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4952  	if (skb_orphan_frags(head_skb, GFP_ATOMIC))
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4953  		return ERR_PTR(-ENOMEM);
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4954  
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4955  	nfrags = skb_shinfo(head_skb)->nr_frags;
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4956  	frag = skb_shinfo(head_skb)->frags;
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4957  	frag_skb = head_skb;
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4958  
f4c50d990dcf11a Herbert Xu               2006-06-22  4959  	do {

because we're in a do while loop.

f4c50d990dcf11a Herbert Xu               2006-06-22  4960  		struct sk_buff *nskb;
8cb19905e9287a9 Michael S. Tsirkin       2014-03-10  4961  		skb_frag_t *nskb_frag;
c8884edd0787489 Herbert Xu               2006-10-29  4962  		int hsize;
f4c50d990dcf11a Herbert Xu               2006-06-22  4963  		int size;
f4c50d990dcf11a Herbert Xu               2006-06-22  4964  
3953c46c3ac7eef Marcelo Ricardo Leitner  2016-06-02  4965  		if (unlikely(mss == GSO_BY_FRAGS)) {
3953c46c3ac7eef Marcelo Ricardo Leitner  2016-06-02  4966  			len = list_skb->len;
3953c46c3ac7eef Marcelo Ricardo Leitner  2016-06-02  4967  		} else {
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4968  			len = head_skb->len - offset;
f4c50d990dcf11a Herbert Xu               2006-06-22  4969  			if (len > mss)
f4c50d990dcf11a Herbert Xu               2006-06-22  4970  				len = mss;
3953c46c3ac7eef Marcelo Ricardo Leitner  2016-06-02  4971  		}
f4c50d990dcf11a Herbert Xu               2006-06-22  4972  
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  4973  		hsize = skb_headlen(head_skb) - offset;
f4c50d990dcf11a Herbert Xu               2006-06-22  4974  
dbd50f238decfe5 Xin Long                 2021-01-15  4975  		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  4976  		    (skb_headlen(list_skb) == len || sg)) {
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  4977  			BUG_ON(skb_headlen(list_skb) > len);
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4978  
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4979  			nskb = skb_clone(list_skb, GFP_ATOMIC);
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4980  			if (unlikely(!nskb))
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4981  				goto err;

So on the second iteration "err" is zero.

2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  4982  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4983  			i = 0;
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  4984  			nfrags = skb_shinfo(list_skb)->nr_frags;
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  4985  			frag = skb_shinfo(list_skb)->frags;
1fd819ecb90cc9b Michael S. Tsirkin       2014-03-10  4986  			frag_skb = list_skb;
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  4987  			pos += skb_headlen(list_skb);
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4988  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4989  			while (pos < offset + len) {
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4990  				BUG_ON(i >= nfrags);
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4991  
4e1beba12d094c6 Michael S. Tsirkin       2014-03-10  4992  				size = skb_frag_size(frag);
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4993  				if (pos + size > offset + len)
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4994  					break;
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4995  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4996  				i++;
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4997  				pos += size;
4e1beba12d094c6 Michael S. Tsirkin       2014-03-10  4998  				frag++;
9d8506cc2d7ea1f Herbert Xu               2013-11-21  4999  			}
89319d3801d1d3a Herbert Xu               2008-12-15  5000  
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  5001  			list_skb = list_skb->next;
89319d3801d1d3a Herbert Xu               2008-12-15  5002  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5003  			if (unlikely(pskb_trim(nskb, len))) {
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5004  				kfree_skb(nskb);
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5005  				goto err;
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5006  			}
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5007  
ec47ea824774046 Alexander Duyck          2012-05-04  5008  			hsize = skb_end_offset(nskb);
89319d3801d1d3a Herbert Xu               2008-12-15  5009  			if (skb_cow_head(nskb, doffset + headroom)) {
89319d3801d1d3a Herbert Xu               2008-12-15  5010  				kfree_skb(nskb);
89319d3801d1d3a Herbert Xu               2008-12-15  5011  				goto err;
89319d3801d1d3a Herbert Xu               2008-12-15  5012  			}
89319d3801d1d3a Herbert Xu               2008-12-15  5013  
ec47ea824774046 Alexander Duyck          2012-05-04  5014  			nskb->truesize += skb_end_offset(nskb) - hsize;
89319d3801d1d3a Herbert Xu               2008-12-15  5015  			skb_release_head_state(nskb);
89319d3801d1d3a Herbert Xu               2008-12-15  5016  			__skb_push(nskb, doffset);
89319d3801d1d3a Herbert Xu               2008-12-15  5017  		} else {
00b229f762b020e Paolo Abeni              2021-01-19  5018  			if (hsize < 0)
00b229f762b020e Paolo Abeni              2021-01-19  5019  				hsize = 0;
dbd50f238decfe5 Xin Long                 2021-01-15  5020  			if (hsize > len || !sg)
dbd50f238decfe5 Xin Long                 2021-01-15  5021  				hsize = len;
dbd50f238decfe5 Xin Long                 2021-01-15  5022  
c93bdd0e03e8485 Mel Gorman               2012-07-31  5023  			nskb = __alloc_skb(hsize + doffset + headroom,
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  5024  					   GFP_ATOMIC, skb_alloc_rx_flag(head_skb),
c93bdd0e03e8485 Mel Gorman               2012-07-31  5025  					   NUMA_NO_NODE);
89319d3801d1d3a Herbert Xu               2008-12-15  5026  
89319d3801d1d3a Herbert Xu               2008-12-15  5027  			if (unlikely(!nskb))
89319d3801d1d3a Herbert Xu               2008-12-15  5028  				goto err;
89319d3801d1d3a Herbert Xu               2008-12-15  5029  
89319d3801d1d3a Herbert Xu               2008-12-15  5030  			skb_reserve(nskb, headroom);
89319d3801d1d3a Herbert Xu               2008-12-15  5031  			__skb_put(nskb, doffset);
89319d3801d1d3a Herbert Xu               2008-12-15  5032  		}
89319d3801d1d3a Herbert Xu               2008-12-15  5033  
f4c50d990dcf11a Herbert Xu               2006-06-22  5034  		if (segs)
f4c50d990dcf11a Herbert Xu               2006-06-22  5035  			tail->next = nskb;
f4c50d990dcf11a Herbert Xu               2006-06-22  5036  		else
f4c50d990dcf11a Herbert Xu               2006-06-22  5037  			segs = nskb;
f4c50d990dcf11a Herbert Xu               2006-06-22  5038  		tail = nskb;
f4c50d990dcf11a Herbert Xu               2006-06-22  5039  
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  5040  		__copy_skb_header(nskb, head_skb);
f4c50d990dcf11a Herbert Xu               2006-06-22  5041  
b0cf97975a1cf81 Zihan Xi                 2026-07-29  5042  		err = skb_headers_offset_update_careful(nskb, skb_headroom(nskb) - headroom);
b0cf97975a1cf81 Zihan Xi                 2026-07-29  5043  		if (unlikely(err))
b0cf97975a1cf81 Zihan Xi                 2026-07-29  5044  			goto err;
fcdfe3a7fa4cb74 Vlad Yasevich            2014-07-31  5045  		skb_reset_mac_len(nskb);
68c331631143f5f Pravin B Shelar          2013-02-14  5046  
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  5047  		skb_copy_from_linear_data_offset(head_skb, -tnl_hlen,
68c331631143f5f Pravin B Shelar          2013-02-14  5048  						 nskb->data - tnl_hlen,
68c331631143f5f Pravin B Shelar          2013-02-14  5049  						 doffset + tnl_hlen);
89319d3801d1d3a Herbert Xu               2008-12-15  5050  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5051  		if (nskb->len == len + doffset)
1cdbcb7957cf9e5 Simon Horman             2013-05-19  5052  			goto perform_csum_check;
89319d3801d1d3a Herbert Xu               2008-12-15  5053  
7fbeffed77c130e Alexander Duyck          2016-02-05  5054  		if (!sg) {
1454c9fa9106584 Yadu Kishore             2020-03-17  5055  			if (!csum) {
7fbeffed77c130e Alexander Duyck          2016-02-05  5056  				if (!nskb->remcsum_offload)
6f85a124d819e1c Herbert Xu               2008-08-15  5057  					nskb->ip_summed = CHECKSUM_NONE;
764434562270971 Alexander Duyck          2016-02-05  5058  				SKB_GSO_CB(nskb)->csum =
764434562270971 Alexander Duyck          2016-02-05  5059  					skb_copy_and_csum_bits(head_skb, offset,
1454c9fa9106584 Yadu Kishore             2020-03-17  5060  							       skb_put(nskb,
1454c9fa9106584 Yadu Kishore             2020-03-17  5061  								       len),
8d5930dfb7edbf1 Al Viro                  2020-07-10  5062  							       len);
7e2b10c1e52ca37 Tom Herbert              2014-06-04  5063  				SKB_GSO_CB(nskb)->csum_start =
de843723f9b9891 Tom Herbert              2014-06-25  5064  					skb_headroom(nskb) + doffset;
1454c9fa9106584 Yadu Kishore             2020-03-17  5065  			} else {
c624c58e08b1510 lily                     2022-08-22  5066  				if (skb_copy_bits(head_skb, offset, skb_put(nskb, len), len))
c624c58e08b1510 lily                     2022-08-22  5067  					goto err;
1454c9fa9106584 Yadu Kishore             2020-03-17  5068  			}
f4c50d990dcf11a Herbert Xu               2006-06-22  5069  			continue;
f4c50d990dcf11a Herbert Xu               2006-06-22  5070  		}
f4c50d990dcf11a Herbert Xu               2006-06-22  5071  
8cb19905e9287a9 Michael S. Tsirkin       2014-03-10  5072  		nskb_frag = skb_shinfo(nskb)->frags;
f4c50d990dcf11a Herbert Xu               2006-06-22  5073  
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  5074  		skb_copy_from_linear_data_offset(head_skb, offset,
d626f62b11e00c1 Arnaldo Carvalho de Melo 2007-03-27  5075  						 skb_put(nskb, hsize), hsize);
f4c50d990dcf11a Herbert Xu               2006-06-22  5076  
48f6a5356a33dd7 Hyunwoo Kim              2026-05-16  5077  		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
48f6a5356a33dd7 Hyunwoo Kim              2026-05-16  5078  					    skb_shinfo(frag_skb)->flags) &
06b4feb37e64e54 Jonathan Lemon           2021-01-06  5079  					   SKBFL_SHARED_FRAG;
cef401de7be8c4e Eric Dumazet             2013-01-25  5080  
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  5081  		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
bf5c25d608613ea Willem de Bruijn         2017-12-22  5082  			goto err;
bf5c25d608613ea Willem de Bruijn         2017-12-22  5083  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5084  		while (pos < offset + len) {
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5085  			if (i >= nfrags) {
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  5086  				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  5087  				    skb_zerocopy_clone(nskb, list_skb,
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  5088  						       GFP_ATOMIC))
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  5089  					goto err;
2ea35288c83b3d5 Mohamed Khalfella        2023-08-31  5090  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5091  				i = 0;
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  5092  				nfrags = skb_shinfo(list_skb)->nr_frags;
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  5093  				frag = skb_shinfo(list_skb)->frags;
1fd819ecb90cc9b Michael S. Tsirkin       2014-03-10  5094  				frag_skb = list_skb;
48f6a5356a33dd7 Hyunwoo Kim              2026-05-16  5095  
48f6a5356a33dd7 Hyunwoo Kim              2026-05-16  5096  				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
48f6a5356a33dd7 Hyunwoo Kim              2026-05-16  5097  
13acc94eff122b2 Yonghong Song            2018-03-21  5098  				if (!skb_headlen(list_skb)) {
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5099  					BUG_ON(!nfrags);
13acc94eff122b2 Yonghong Song            2018-03-21  5100  				} else {
13acc94eff122b2 Yonghong Song            2018-03-21  5101  					BUG_ON(!list_skb->head_frag);
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5102  
13acc94eff122b2 Yonghong Song            2018-03-21  5103  					/* to make room for head_frag. */
13acc94eff122b2 Yonghong Song            2018-03-21  5104  					i--;
13acc94eff122b2 Yonghong Song            2018-03-21  5105  					frag--;
13acc94eff122b2 Yonghong Song            2018-03-21  5106  				}
bf5c25d608613ea Willem de Bruijn         2017-12-22  5107  
1a4cedaf65491e6 Michael S. Tsirkin       2014-03-10  5108  				list_skb = list_skb->next;
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5109  			}
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5110  
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5111  			if (unlikely(skb_shinfo(nskb)->nr_frags >=
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5112  				     MAX_SKB_FRAGS)) {
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5113  				net_warn_ratelimited(
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5114  					"skb_segment: too many frags: %u %u\n",
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5115  					pos, mss);
ff907a11a0d68a7 Eric Dumazet             2018-07-19  5116  				err = -EINVAL;
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5117  				goto err;
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5118  			}
9d8506cc2d7ea1f Herbert Xu               2013-11-21  5119  
13acc94eff122b2 Yonghong Song            2018-03-21  5120  			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
173e7622ccb3f46 Mina Almasry             2024-05-02  5121  			__skb_frag_ref(nskb_frag);
8cb19905e9287a9 Michael S. Tsirkin       2014-03-10  5122  			size = skb_frag_size(nskb_frag);
f4c50d990dcf11a Herbert Xu               2006-06-22  5123  
f4c50d990dcf11a Herbert Xu               2006-06-22  5124  			if (pos < offset) {
b54c9d5bd6e38ed Jonathan Lemon           2019-07-30  5125  				skb_frag_off_add(nskb_frag, offset - pos);
8cb19905e9287a9 Michael S. Tsirkin       2014-03-10  5126  				skb_frag_size_sub(nskb_frag, offset - pos);
f4c50d990dcf11a Herbert Xu               2006-06-22  5127  			}
f4c50d990dcf11a Herbert Xu               2006-06-22  5128  
89319d3801d1d3a Herbert Xu               2008-12-15  5129  			skb_shinfo(nskb)->nr_frags++;
f4c50d990dcf11a Herbert Xu               2006-06-22  5130  
f4c50d990dcf11a Herbert Xu               2006-06-22  5131  			if (pos + size <= offset + len) {
f4c50d990dcf11a Herbert Xu               2006-06-22  5132  				i++;
4e1beba12d094c6 Michael S. Tsirkin       2014-03-10  5133  				frag++;
f4c50d990dcf11a Herbert Xu               2006-06-22  5134  				pos += size;
f4c50d990dcf11a Herbert Xu               2006-06-22  5135  			} else {
8cb19905e9287a9 Michael S. Tsirkin       2014-03-10  5136  				skb_frag_size_sub(nskb_frag, pos + size - (offset + len));
89319d3801d1d3a Herbert Xu               2008-12-15  5137  				goto skip_fraglist;
f4c50d990dcf11a Herbert Xu               2006-06-22  5138  			}
f4c50d990dcf11a Herbert Xu               2006-06-22  5139  
8cb19905e9287a9 Michael S. Tsirkin       2014-03-10  5140  			nskb_frag++;
f4c50d990dcf11a Herbert Xu               2006-06-22  5141  		}
f4c50d990dcf11a Herbert Xu               2006-06-22  5142  
89319d3801d1d3a Herbert Xu               2008-12-15  5143  skip_fraglist:
f4c50d990dcf11a Herbert Xu               2006-06-22  5144  		nskb->data_len = len - hsize;
f4c50d990dcf11a Herbert Xu               2006-06-22  5145  		nskb->len += nskb->data_len;
f4c50d990dcf11a Herbert Xu               2006-06-22  5146  		nskb->truesize += nskb->data_len;
ec5f06156423889 Pravin B Shelar          2013-03-07  5147  
1cdbcb7957cf9e5 Simon Horman             2013-05-19  5148  perform_csum_check:
7fbeffed77c130e Alexander Duyck          2016-02-05  5149  		if (!csum) {
ff907a11a0d68a7 Eric Dumazet             2018-07-19  5150  			if (skb_has_shared_frag(nskb) &&
ff907a11a0d68a7 Eric Dumazet             2018-07-19  5151  			    __skb_linearize(nskb))
ddff00d420432d5 Alexander Duyck          2016-02-05  5152  				goto err;
ff907a11a0d68a7 Eric Dumazet             2018-07-19  5153  
7fbeffed77c130e Alexander Duyck          2016-02-05  5154  			if (!nskb->remcsum_offload)
ec5f06156423889 Pravin B Shelar          2013-03-07  5155  				nskb->ip_summed = CHECKSUM_NONE;
764434562270971 Alexander Duyck          2016-02-05  5156  			SKB_GSO_CB(nskb)->csum =
764434562270971 Alexander Duyck          2016-02-05  5157  				skb_checksum(nskb, doffset,
764434562270971 Alexander Duyck          2016-02-05  5158  					     nskb->len - doffset, 0);
7e2b10c1e52ca37 Tom Herbert              2014-06-04  5159  			SKB_GSO_CB(nskb)->csum_start =
7e2b10c1e52ca37 Tom Herbert              2014-06-04  5160  				skb_headroom(nskb) + doffset;
ec5f06156423889 Pravin B Shelar          2013-03-07  5161  		}
df5771ffefb13f8 Michael S. Tsirkin       2014-03-10  5162  	} while ((offset += len) < head_skb->len);
f4c50d990dcf11a Herbert Xu               2006-06-22  5163  
bec3cfdca36bf43 Eric Dumazet             2014-10-03  5164  	/* Some callers want to get the end of the list.
bec3cfdca36bf43 Eric Dumazet             2014-10-03  5165  	 * Put it in segs->prev to avoid walking the list.
bec3cfdca36bf43 Eric Dumazet             2014-10-03  5166  	 * (see validate_xmit_skb_list() for example)
bec3cfdca36bf43 Eric Dumazet             2014-10-03  5167  	 */
bec3cfdca36bf43 Eric Dumazet             2014-10-03  5168  	segs->prev = tail;
432c856fcf45c46 Toshiaki Makita          2014-10-27  5169  
802ab55adc39a06 Alexander Duyck          2016-04-10  5170  	if (partial_segs) {
07b26c9454a2a19 Steffen Klassert         2016-09-19  5171  		struct sk_buff *iter;
802ab55adc39a06 Alexander Duyck          2016-04-10  5172  		int type = skb_shinfo(head_skb)->gso_type;
07b26c9454a2a19 Steffen Klassert         2016-09-19  5173  		unsigned short gso_size = skb_shinfo(head_skb)->gso_size;
802ab55adc39a06 Alexander Duyck          2016-04-10  5174  
802ab55adc39a06 Alexander Duyck          2016-04-10  5175  		/* Update type to add partial and then remove dodgy if set */
07b26c9454a2a19 Steffen Klassert         2016-09-19  5176  		type |= (features & NETIF_F_GSO_PARTIAL) / NETIF_F_GSO_PARTIAL * SKB_GSO_PARTIAL;
802ab55adc39a06 Alexander Duyck          2016-04-10  5177  		type &= ~SKB_GSO_DODGY;
802ab55adc39a06 Alexander Duyck          2016-04-10  5178  
802ab55adc39a06 Alexander Duyck          2016-04-10  5179  		/* Update GSO info and prepare to start updating headers on
802ab55adc39a06 Alexander Duyck          2016-04-10  5180  		 * our way back down the stack of protocols.
802ab55adc39a06 Alexander Duyck          2016-04-10  5181  		 */
07b26c9454a2a19 Steffen Klassert         2016-09-19  5182  		for (iter = segs; iter; iter = iter->next) {
07b26c9454a2a19 Steffen Klassert         2016-09-19  5183  			skb_shinfo(iter)->gso_size = gso_size;
07b26c9454a2a19 Steffen Klassert         2016-09-19  5184  			skb_shinfo(iter)->gso_segs = partial_segs;
07b26c9454a2a19 Steffen Klassert         2016-09-19  5185  			skb_shinfo(iter)->gso_type = type;
07b26c9454a2a19 Steffen Klassert         2016-09-19  5186  			SKB_GSO_CB(iter)->data_offset = skb_headroom(iter) + doffset;
07b26c9454a2a19 Steffen Klassert         2016-09-19  5187  		}
07b26c9454a2a19 Steffen Klassert         2016-09-19  5188  
07b26c9454a2a19 Steffen Klassert         2016-09-19  5189  		if (tail->len - doffset <= gso_size)
07b26c9454a2a19 Steffen Klassert         2016-09-19  5190  			skb_shinfo(tail)->gso_size = 0;
07b26c9454a2a19 Steffen Klassert         2016-09-19  5191  		else if (tail != segs)
07b26c9454a2a19 Steffen Klassert         2016-09-19  5192  			skb_shinfo(tail)->gso_segs = DIV_ROUND_UP(tail->len - doffset, gso_size);
802ab55adc39a06 Alexander Duyck          2016-04-10  5193  	}
802ab55adc39a06 Alexander Duyck          2016-04-10  5194  
432c856fcf45c46 Toshiaki Makita          2014-10-27  5195  	/* Following permits correct backpressure, for protocols
432c856fcf45c46 Toshiaki Makita          2014-10-27  5196  	 * using skb_set_owner_w().
432c856fcf45c46 Toshiaki Makita          2014-10-27  5197  	 * Idea is to tranfert ownership from head_skb to last segment.
432c856fcf45c46 Toshiaki Makita          2014-10-27  5198  	 */
432c856fcf45c46 Toshiaki Makita          2014-10-27  5199  	if (head_skb->destructor == sock_wfree) {
432c856fcf45c46 Toshiaki Makita          2014-10-27  5200  		swap(tail->truesize, head_skb->truesize);
432c856fcf45c46 Toshiaki Makita          2014-10-27  5201  		swap(tail->destructor, head_skb->destructor);
432c856fcf45c46 Toshiaki Makita          2014-10-27  5202  		swap(tail->sk, head_skb->sk);
432c856fcf45c46 Toshiaki Makita          2014-10-27  5203  	}
f4c50d990dcf11a Herbert Xu               2006-06-22  5204  	return segs;
f4c50d990dcf11a Herbert Xu               2006-06-22  5205  
f4c50d990dcf11a Herbert Xu               2006-06-22  5206  err:
289dccbe141e01e Eric Dumazet             2013-12-20  5207  	kfree_skb_list(segs);
f4c50d990dcf11a Herbert Xu               2006-06-22 @5208  	return ERR_PTR(err);
f4c50d990dcf11a Herbert Xu               2006-06-22  5209  }

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

