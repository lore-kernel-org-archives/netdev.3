Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FDA4CB8C8
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989646; cv=none; b=EWELbsAj71Z/8vXIuEnNLJVKjHfqpsxME5HATIOfh1Q13vO5rJaXMnE8tv1pVxqruH2BgjZt12+BQ/IRfQx+kofUQ8C4DGkasQPpUpJvgLn2XI4FdbJxeJuT5jwMOPYJOQt5Ptd68f87pJl6UcXfTuPcXmrBlI/wzgIYMe2Aq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989646; c=relaxed/simple;
	bh=jXQ1ok6/4ySngbdOAAmTV4VGfVoNwaS9vIa9Gwf57h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuOFKU1CJWHbIX2eRPO/qeXE9LAGkMxAqLe8uki2vOQ1vZa3RbKi1cNzVHJzt2Rkn4onhBbM1JAagFD5I2vjZQYqbGv5jLMGVf0g0KLAR5ytcCdajY6UBQuo5/jKtV2+QGFsB5y1zPbyTcn4iaRN6d4yoXGp7JE8YhWJx20E5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyqKc3Iv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyqKc3Iv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1a873d9aeso2588705e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791989639; x=1792594439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysEXf6P+RoEe/ZMsN84LXJemZvSuyVskDydvilx9tig=;
        b=gyqKc3Iv6tne83uTYZEG812otEaNlC+tFXGwibVc7MCNVXzE61BZvaPzeqUmzrpEIy
         cNmvXNCWETV2dFWZmqQQT9MUkFfslMAsDo36un1qOR9Qe2YI7fo0bVt7nbU/7jtxJgK3
         uoaRdIn/JNt3t+PHM1TZUChJ4jdxENKFmp+CtuA2Zi3WBzUlqFX2rbZnDjYH/Ergm1dg
         fQ6d6++xxb6l2PrRYyG8u+O+hvDoqUvQkR2V82UvwXi48sm80Bfoo8/v1X2HsOFosHvC
         gyxTtAbrPppYC9vSbDAQaFs7xMekcQJsSUOdvXom865kvbqKI4sA6fmC+a7Znk7cMZOm
         /6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989639; x=1792594439;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysEXf6P+RoEe/ZMsN84LXJemZvSuyVskDydvilx9tig=;
        b=dmmAe+c2t32M0b/L6vbBOPjLgbTB2cuqcC4s2J/5by5j5TdzIRZj1OWjNkeBu56Osb
         Rae2kVJpBYHtNfGDa7Xzf5KmZZBl591e9UHMi51DUlYkKmGtRAryHmFYVLEJLd6dJX4M
         XjnMaQ3/rDDbL5i+A81wMzJ/cI4Sg9q0SAlXZJPX27QEZtOsfTRHQQSLIxkf1fNzdvfF
         TGMGDkEe+FTo+2/Wp42akGUutqos46DR9mEdsXkimjiW0gM5RAZD/LMW7USbWvxAgNnt
         nn+4GQKp/jcRilUw9G8GYsou++127Dr18zPanmwe9hC7MopPs+LNpHqR/OGxJSNhfCl2
         BfzA==
X-Gm-Message-State: AFq9FYIof+sKiZeHP2FPgytCy0xjuFe0z6ysJdkdXNr4FG8DJqCXg5qK
	32wxNyWZwJXsh6mkcWH5MVQLywLs9N1N94Mo25Su225MI3HuYWcRvKhM
X-Gm-Gg: AYBFou0r7h1SAGF6cpwBhdXjZdEPMeok4+o0rnC+G9vJ67N12T9thYVp7cjjcZzHz4F
	cFPLT/V1laUZ8Qrua3clS/lUevRTjvNOIN3k4oRQCBFPDHEa0e62R59InM/k8SMAk/FKiZnC0p6
	pz4ZWab8mdxlNzR+8FMCndt2IkmBAJMYrAshS/5diJF6WuonMRfyYqpv8hHKoz2W0Uw0DHzQkoV
	lOTQYT57Vfn5HJi0TJCWnyq6vMbLce/mXwwj2N/WYr47SyjALfO67EWbqcidDqBB/b7k3sKZI6J
	QOYjoD+FGAV5yyvofdQpreH1osaKbVL8vs/LfRRGqmxfjYp/ia+3TGqrzKyeLoVsKuk8XLPzWOn
	z6a2hAFPi9NMvzuQc3al6e+9c2/TO3RQGlr17l8pPI+yBLMTRHzlOGgTYAuYpONEOXGS1gmJ2U9
	ZiUJgztf19cEubLHR19pg/N4mYW5LTt6J+8sEQUMMAv7AGR0OX8PGGHGHi3zxgHo2EjOkuFvyUl
	Xra57E8b0L3ta96Vx+Kh3p4rkA4ZVxWDwLpqx0SjptwyDdskqHvB3hhSnZn7ANQROEOd75qC+BN
	sWECsk4yaMmXm3gkfwUHP9ME07r8/zRpV0dE5bWLl9zUW7Z8E3eVrH/HBHScO04eZSi3QcIvqaX
	14FHLlmLpeJuCWhDq7UYW
X-Received: by 2002:a05:600c:6285:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a18e4760demr324921595e9.1.1791989638272;
        Wed, 14 Oct 2026 07:53:58 -0700 (PDT)
Received: from ?IPV6:2a02:3100:5ad1:60fc:7c7a:4c9b:4d41:afaf? (dynamic-2a02-3100-5ad1-60fc-7c7a-4c9b-4d41-afaf.310.pool.telefonica.de. [2a02:3100:5ad1:60fc:7c7a:4c9b:4d41:afaf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b482b3e4sm52818595e9.4.2026.10.14.07.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:53:57 -0700 (PDT)
Message-ID: <e69879b3-5374-4b85-ac97-f21f995b8544@gmail.com>
Date: Wed, 14 Oct 2026 16:53:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 3/4] net: hsr: segment GSO before per-frame
 forwarding
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20261009201324.17-1-xiexinet@gmail.com>
 <20261009201324.17-4-xiexinet@gmail.com>
 <20261014140047.Z8nhXzxa@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 xsDNBGpiHugBDADJ5KuJaOYfUx7TGbRw0UE1km4dLnJomCSNtgq2T9BqgZ6TRPEy37soAmW3
 XxCPvhfL6CPLldzy6O6EkUD7/8zlbQP1DM6gUIQUyKxxkb8uR+oCogDKjsxt0QPycP/dR9fk
 SL4qKReprnkOOcGeLahLHzofVdn46mc5igCBsAA/PPSpo1GqsfGk+zYV97rSVa8zhnSXsqZ/
 9DbUfQynZKVqYN4tm1B30JE5SEWDCko95Qw9fAORX2W356MOQJGr05z9qMSy7CkF7bAUkziG
 d6ZSPsGEsel5jYByP8ZvwQ2A8kdKpRy8+zQCaC+vEotTH7Fs7SIzE/Z5mEVIi1xQqEzN1rqG
 BW7KgzRDWjw8lKsoBbxv20nfhUzuZLan2HzUJ+LxZ18Os4zkWg9sxHgMi+AGqn/+0ppbDcOH
 9Jm072/xA7O1MCXLgr4FOP+4PJH1vcqU+0EZVz7KCjrwkdz+l5Ojso2FLXq2MGoqWGShIsDV
 bF1JYpgm4spdPbnISkidUC0AEQEAAc0cWGluIFhpZSA8eGlleGluZXRAZ21haWwuY29tPsLB
 DQQTAQgANxYhBAHOahKZFnMu2n/CxrTrSufyPi3LBQJqYh7oBQkFo5qAAhsDBAsJCAcFFQgJ
 CgsFFgIDAQAACgkQtOtK5/I+LctmngwAlmrGPWnWxDW6PSJeR9SM0faqwuY33TWAE35nshm/
 EEkBgpVVhG4z4Cdy7L+6TG6NHVDnvl+IHLyyOZlL3LQPQIpiKVgo6jHmm9TF6mK+Vo3nsXAA
 uSJYu9iY9Aywmy2JVQ15ttQ0NfcoZ0sV14bT7pSr9zXB6D8p3XA4AQI6IBeLvj993Z1+tPyC
 6BJ+2aWWLBx7xGpFo3X8dhjS/Lm8QoietKbI+ACefKKCDNiM2KG53P76wdXJp52u4dqP6eFc
 +Qv35QefnALoPkOGQEdd1qvUycyZhuaCj8h0AxDu7bL3G/IM8G2K8qsbSJuui8zCSZ9b/QZf
 H7u1nevPOgxyWC1Pep/TbRZ62ktn8lrmWA8PZjuaJJQGjahuK1GgTQZNG+7DB7NwjLr6aXIm
 JirtT4FeR+IUovvL/ll+VHzpGpFbgXz4GTsWsikQkT1huFSB8MRLlWMXdAKblL96L754j8Z5
 p/YV26YTppXI56uJ3XyOwZSrfrK1pfqNIp2Yr9vUzsDNBGpiHukBDACePM1YZ1FvAiFay/2v
 KVDNpuazmpVb1CBFy+rqM9HcuHe+5CuxLd4RI4hb0qmjlm5Vi5M8+AuNB/wi/f8oDuhJwlMn
 v9L0lfgpRRdShnB26hnt2wWwWFgOU3BwymSruxhEYq+eIjjxCAo6yW7Qm+ArZ+riETMI67sy
 ZyLx6o4yRiWxOrh1nhwV/f6PIOl+Iv4yLAG3eFXpU7/EZpim610bKMwcXEpiRkf3NjiflIha
 adoKHV0LCiVNrU7r8TICjjnugpl1tXAR2RlaRcSxmvOzrXY2O/xBLpwPr5erbdk8RCaxUzS0
 kK0hw+/On3Sr4Z4gtLl2xtDkjRh3KQ9ZqMPrFD/5XOs842ueNivwIyAf2kQJjKfJGWc771EM
 0ZWo1r1AthbuM+IeN5QM74rMJxaf5WyDX3ZeqBA55fCJGJ3zrp7Tqeoq8DYufiNkppE9S71z
 Cvxva2f8mUWTlTUf8s33sRD7C87XpT0whKpn1I9/nJB9Kb0dKyRCdcsT4o1ynxUAEQEAAcLA
 /AQYAQgAJhYhBAHOahKZFnMu2n/CxrTrSufyPi3LBQJqYh7pBQkFo5qAAhsMAAoJELTrSufy
 Pi3L/iwL/3aoCeq19Pog3fqisRyEZeX8pXw2GYlrJWYoM0mQ1USaTpdsMwCXaoFMoSBqid0F
 VPrqlH4bSIEEAzVmFPX0NjGhREDMrQ9eR5S9yqSpBvX+hz+xgpt4NOPhbVQmV+9f4lX9TJT7
 GOO3EX2eeokg6ZAISycCAx7srXuc8oyRTJtnUQziH9GXrEeon88LHf1QHg0Z0sL/c7DfDqvW
 9924M4ngQAZ8RgCBGZocoWuXCemSPkfQVLt5DzycSgSQODhbNSEmr+jb1V9Svf9D9k0CQfEY
 cB3uwOHWb6Z/yaEARbGZPSPn89YjXBncQTpgSvUM578b5x3pKi6PjZB/hwtUsRgrWGWoIwRi
 +ZmcHnCzsuo6uuNYX8VvmWqYsVajykjnpjdCGmU89QUsVmrtnDPBrfr8VVJcZPnCJhE595Pk
 LO29Oj0au9kr7kMW5Q+fBeHj5zz6VggAaRRU74/sgtwLODBWESPZ9LqUUdB5L/XbrSq2VDlD
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20261014140047.Z8nhXzxa@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> I've been re-reading the old mails. The whole thing is needed for GSO
> when it can not be disabled, right? And VETH interface has been named as
> an example.

Not only. GRO can be disabled, and patch 1 does that. Patch 3 is for
GSO skbs that arrive without any GRO. The case is the one from the
cover letter: a software PRP RedBox on a Linux host, with containers
or VMs on the SAN side and two NICs for the PRP LANs.

  container/netns                  host PRP RedBox
  prp0-peer ---- veth ---- prp0-int (interlink RX)
                                  |
                           split GSO into frames
                                  |
                           sequence number + RCT
                              /          \
                           LAN A        LAN B

When the container sends a large TCP or UDP skb, veth hands it to
prp0-int as one GSO skb. Nothing on that path segments it, and GRO on
prp0-int plays no role. The same happens with virtio or tap. PRP must
give every wire frame its own sequence number and RCT, so patch 3
splits the skb before that. A NIC with GRO_HW that cannot be switched
off is the second case. Local traffic from the HSR master is handled by
removing the GSO features, so the core segments it before
ndo_start_xmit().

> There was also a bridge device. With HSR you form a ring. With a bridge
> you attach other (physical) devices within the ring. This does not sound
> like real life use-case. Do I miss something?

The bridge only came up in the v6 discussion as a comparison: when a
bridge forwards a GSO skb to a physical port, the TX path segments it,
but it cannot add a PRP RCT and sequence number to each segment. We do
not use a bridge inside the ring.

-- 
Xin
