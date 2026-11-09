Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189435;
	b=j4BY9g8c8fVL/NwRdhHPOZolKxJ1Hpw047g4J+1ft+7oyw+9qSG3BQG24BjQz5bVh2/2
	 1G+tCma910ik0TLXXC7QBk7AfVDhGBi56Jiy3lGgXeeT/PytMZ8SQWA6ooCkhn5DnQvFv
	 uQ4t0fEYaBcb7QBSVAbVj0h9aA6A/QF3jMPRrJlKEpkzGMboyU0XuWomdXtqy4Y7PfeRf
	 eH0np/41t0z4RH8SJ4B7/zl5FDXy5taD6hcS7ivIi34WhU7NZkN4RqifX7aNAbwG5YC9e
	 /Z3U10cytlhRF/1K954HtWQEWN/aP5EVTKuDxZYwnyLdYVqThUK/uGc7VG2mbMcACUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8wgCcx+Ych3tnKf4y17fQUirM+lM1wAIJTSbb/Fy8Zk=;
	b=AkYud5dW1Ndc3uwv78XPAdhkui3Zjlc7RjRglgfM5HiKpIId/joAsmmOEPvshzVqSbYz
	 Mxwl/HGvBZSMqXtxpKde6XoZ2JC3crC/S75SFViHgOG3GPvBFHwfXrEwCyPA8ONFOegC2
	 bS1waP4Du7nHcMPNvzRWVgQtcGPKEcetnY6Jyg8RF18VTLA8E9fLk8D6L2HDTDZ8ZCnGZ
	 N5iE2B0DDsEtNIvxO0pX5Ig1RPxZtj1t2NHxeckAD3cnj/AhHYBbWDzPCLyWtlgbsxQjo
	 b4/1BvlwD/6HiyuUguT4INHhVoipBOi+hknubO8RHSelq17ESZZUhuALOLuThU6xJcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="Mzch/vZ7";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A32606A320
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75A32606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Mzch/vZ7
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ccca948203aso100356a12.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794189435; x=1794794235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8wgCcx+Ych3tnKf4y17fQUirM+lM1wAIJTSbb/Fy8Zk=;
        b=Mzch/vZ77PPC0ZEwmvn877V3B8RBxkYhyLS9bK3fzVOiZACTCpXLJl8CMwdT/RaIh6
         6Io4gyFPlmZzG0k3rbWSqyKP4U7EM52lgsWVMAXn8OaI/H7iXAW9hj/oTsrD/vhijUao
         xO31gVlzJ2oeiCyDPasokX5lFZmKmijid9VR/vbN4IS0JnQLrf1rh3bdWoZY1YyyCtk3
         pvIVPoXk2CXyabbO+p/Puot8JtdSPvEwolYqjCyv7SyRdBlhP2m7ZmUi3sM7iwkA9OY1
         xfsLCnfFMLb5rvEEwiN8dokfN7yLoPNqTTW43DXLW2zkX8g+IlYbbVcljBQ9S2Xxrj1A
         mPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794189435; x=1794794235;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wgCcx+Ych3tnKf4y17fQUirM+lM1wAIJTSbb/Fy8Zk=;
        b=lDwScLsentksnLuJy7lTnlPsuObGHS8UhXWRaxGm+52Kkl9Zs6iOs6ZfDO0DSnY/6B
         Wd2KAunian2EX0q84uqRZN1rIaEgwtHI/81R1KjGLtMyboyScBKWDBKsXjQAvuMPcamd
         CMIxLfswV5LbkFNrNCJ+vLHxdYM5Wd6u3q1nVd0SWL0GoZxbknQqfM1pz4G47LVLQRP9
         M3RoPMJuoKV860p1KzxBGESO/UTnJOyzJd3fXdEPI3B6tUM5J33MvhfNL76lQvTsEka5
         oFzhkdbV0ygdWmhZUyG5GQSzCOb3GL2VnTdhCbesH1CRPA/b5KIW2taZ9wxChVS15vl1
         OELQ==
X-Gm-Message-State: APuU4Z+nXbWiLgGwXwCyfX2FgsDzJymB9cJ+h6C7moIoOMiLHuVA9EJU
	Uk+rm5dK2SGn5f06afa9BofY4lpAfqcNOAfWHJYUp3ScOWu2BEYkndOipOaubyTfLwNJKb5mlJ0
	MLOdq/uc=
X-Gm-Gg: AYBFou22Aqy88NpcSwFDFEtreBqycv+s0VBk0GSWHKCNas4hMYyRa9EcCxm52ttqsyV
	hEWYg0fKApee1KiFeBHllCr2N8IGsN9GcTyz8FORX+ut3eCayISdBLczLDwn5RDwXihHKd/TUrI
	eLAsQCg+lmy+lYj6pJUpZPN/SvdzHYTWcNqHIaYtP7BuwvKb/4DZyybAKlSAKmAFsJYt6SqVxb+
	+fS6Cf7Sv2KMwsyR02+7UtwtdZi0Y58TR2VzP6bXUqbtMKoiPWGWQmws2SD4VAuAOIWINYpSNNP
	rPLKeHYTGmVhaDJSIQtv1I+MX7PQLgpVUZOHzN57pFsXRgwWgePifn2NzkM2QuryGdGDdkuovTp
	4tDFK2QzK3GTRkGi2cQuDwAHSih921W7xLSAWQn0o0XNX44u4uEJAOrhzn2XDeQo7ofdRhzxRE6
	GGKC/oGGYQVz+xki9gGpCUliLzc1Y3kQrbfigoRhJseLaWjHrVINZ3zh4NBqp0hNJ2LMxLRxqku
	CTJ+BQvsDZ+46RW+lfli/J7YnQisPf84Ht1i5gxTeRemGTZVLM9LuFGj3dJ0aZQ5MiES3GDZj6X
	4h2/Z5paeZMKtu5XGSzfdhw4toZFahtp1O0AgAQkh74vcbSR0LkH3hSNkTxFMT0tuGP5UAuY
X-Received: by 2002:a17:90b:3ecd:b0:3ab:c80:9365 with SMTP id 98e67ed59e1d1-3b12d3e71d8mr2622681a91.42.1794189434631;
        Sun, 08 Nov 2026 17:57:14 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12743e889sm4799418a91.0.2026.11.08.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:57:14 -0800 (PST)
Date: Sun, 8 Nov 2026 17:57:12 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dave Seddon <dave.seddon.ca@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2] libnetlink: zero padding in rta_addattr_l()
Message-ID: <20261108175712.37b4c6f7@phoenix.local>
In-Reply-To: <20261104052901.2735000-1-dave.seddon.ca@gmail.com>
References: <20261104052901.2735000-1-dave.seddon.ca@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 21:29:01 -0800
Dave Seddon <dave.seddon.ca@gmail.com> wrote:

> rta_addattr_l() copies alen bytes but advances the parent by
> RTA_ALIGN(len), so the 1-3 padding bytes are never written. Nests built
> in stack buffers (lwtunnel encap, RTA_MULTIPATH, RTA_METRICS) then send
> those bytes to the kernel. For example, in
> 
>   ip nexthop add id 53 encap mpls 101 ttl 10 via 192.0.2.1 dev d0
> 
> the three bytes after MPLS_IPTUNNEL_TTL are stack contents:
> 
>   05 00 02 00  0a 7f 00 00    MPLS_IPTUNNEL_TTL, ttl 10, stack bytes
>   05 00 02 00  0a 00 00 00    with this patch
> 
> and valgrind reports "sendmsg(msg.msg_iov[0]) points to uninitialised
> byte(s)".
> 
> The kernel skips padding when parsing, so nothing fails, but its own
> encoder zeroes it (__nla_reserve()). Do the same here.
> 
> Fixes: 6ef87f9cce21 ("ip: route: add congestion control metric")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
> ---
> addattr_l() has the same gap, but all its callers zero their request,
> so it is left alone.
> 
> Kernel side: nla_next() advances by NLA_ALIGN(nla_len), so padding is
> never read; __nla_reserve() memsets it to zero.
> ---

Looks good but AI had some bike shedding on details.

Review summary: [PATCH iproute2] libnetlink: zero padding in rta_addattr_l()
Dave Seddon <dave.seddon.ca@gmail.com>, 2026-11-03
Patchwork-Id: 14942963  (delegate: dsahern@gmail.com)

VERDICT
  Fix is correct. Two commit-message problems. 

THE CHANGE
  lib/libnetlink.c, 1 insertion:
    +	memset((void *)subrta + len, 0, RTA_ALIGN(len) - len);

  rta_addattr_l() copies alen bytes but advances the parent by
  RTA_ALIGN(len), so 1-3 padding bytes were never written. Nests built
  in stack buffers sent stack contents to the kernel.

VERIFIED
  - Bounds safe: existing check reserves RTA_ALIGN(rta->rta_len) +
    RTA_ALIGN(len), so the memset cannot pass maxlen. Exact-fit case
    (maxlen=8, alen=1) returns -1 before reaching the memset.
  - alen == 0 (rta_nest path): len = RTA_LENGTH(0) = 4, already
    aligned, memset is a no-op, does not scribble past the header.
  - Byte pattern matches changelog exactly:
      before: 05 00 02 00  0a 7f 00 00
      after:  05 00 02 00  0a 00 00 00
  - Coverage complete: rta_addattr8/16/64 all route through
    rta_addattr_l(). rta_addattr32() needs nothing (len=8, aligned).
  - Applies to oss-nlseq tip (offset -7 lines), builds clean.
    Test apply reverted; working tree untouched.

PROBLEM 1 - note below the --- is wrong
  Claims "addattr_l() has the same gap". It does not. addattr_l() has
  zeroed its padding since 07f9436201eb (2005, "Use NLMSG_TAIL and add
  addraw_l") -- same memset, same file. That is the precedent this
  patch follows, worth citing rather than disclaiming.

PROBLEM 2 - Fixes tag is misdirected
  Fixes: 6ef87f9cce21 ("ip: route: add congestion control metric")
  is a real unaligned caller (RTAX_CC_ALGO string) but not the cause.
  The defect is in rta_addattr_l() itself, back to the BitKeeper
  import (aba5acdf, 2004) -- no useful commit to tag. The MPLS TTL
  reproducer in the changelog is from 9688cf3b, different again.
  Recommend: drop the tag, state in the body that this affects every
  caller passing an unaligned length.

SEVERITY
  Hygiene, not a vulnerability. Kernel nla_next() advances by
  NLA_ALIGN(nla_len) so padding is never parsed; the 1-3 bytes go to
  the kernel, not onto the wire. Real motivations are the valgrind
  report and matching the kernel's own __nla_reserve(). The changelog
  already frames this accurately.

