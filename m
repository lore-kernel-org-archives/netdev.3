Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660023;
	b=djOIGEmuIdj2Hygrivp+1eh65EjcCP1JBiKEcOSSENS2MMla62nnS6ig+g+E8Q7wxlAl
	 1U+nz8DOdDOfudYKJANK4vt+mIqIPq6fQeIZ2n3eN5qlo5sPNxu69y8JEvRLG0+o92a+2
	 p8PCtLJME3mlsQNYT6Bcbe824dHIkvjLWG95WT7kNe/nYnUtY6O8ws5rOLQePvEiiFfRn
	 nibCjO3nCGT9QPv/6EJZ1cXdfVKslpbrI8nOblRIKD/zhoWUGtmiOVG8tMwnx9Hvpatua
	 x5bpOJTmsD2tZW1BsAWviFAVmmGnz4JL7cHyDDYHx37ePG7+4YGJLTGb0vz63HFVD9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P7oo1oMhPZVgU12iVwNehcOih+dQm88y3Gr1jI9txLQ=;
	b=5k2lMxmc2O6OQqkPiAz+noEonEWWWCmSWcAtGPBCJ1k06vidjrFQ8t6kdYK9rk0F6JKT
	 hiXewWZYhLCgHXICf6pOKH9Fq+4xGHfECTHzbtDZv7XIJm2pS8ZAi6puxuniN+TgN2IQC
	 2uRTDtlAOLroML8FUlglSJLIHgvtUDBRhPX5bYq+by3ev0lh5JskcDuezBAxBPBOysQdo
	 RuM1OXR8G5i+ZBRROPf2Jr3MDFvJGwQjHsj5oRK3DFOb7jklP/PcXH6W2jPUNoUnUaJ/w
	 J8nbNqslgu6IXqWyNBeFytSgTuVAAlrJitcz2Be8TzylXwSz5KzkAQIezqN+W0ggD2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SDlc4RDT;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF86606A322
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF86606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SDlc4RDT
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so4339926eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660022; x=1793264822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7oo1oMhPZVgU12iVwNehcOih+dQm88y3Gr1jI9txLQ=;
        b=SDlc4RDTSZy0axDlx0XPE9JP8KPepfr/VELQcYuZZs0JxutnADd4eo8MI475qp1seB
         kXoGILCKB9uMH5+BUb8KnyBNSEtlSQ8/nhPrQYiRlQ2xZuL+rTp5Ulmtas22mQpN95NS
         8ra392nzpxtVI15SDPAvp7ww4zcIhCKZ0UKijmHP9Ohzpfxyy+wlD87RlQBsze6iqNmz
         C9DdMeafkr961E/yjtMAzdzIqjnYBxQx2g2vf+ZfWyyhyufZk3oToT+wQePaewf1HR8U
         RMBTSz3e/vuJFBnrzhX4emvGhk5XYCWMVzqPpug83ZiqyUPWlMU3WVqqC0wHdQEZOSNS
         kzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660022; x=1793264822;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P7oo1oMhPZVgU12iVwNehcOih+dQm88y3Gr1jI9txLQ=;
        b=iFKmcaeLvTa2MoV/JV6WVwdEM+vCuN5gaQNTr9T/M8L/R26rnaD2Ax+NyU6eobLXAE
         SGrdSsn6md6aDEtl2rlW9rWNJS+gzfYYlpJ5l7ElUtd6JEj7MDGsBPKykZZP18A8JGFK
         w5CTBhfGIISQM2JXS+fqVEsDYrCR9BviEEwEnEUZ8aiAiXMFBuiKC0SNlstCA45TTbpS
         zjbV7dxoX5mfmwNFIApAAO0M8/bJqVA9hbIAqW50/03dCVa3HDx6CVkXg7wF6KsJ/Yeb
         GZvpprbeR0/7PMWAhuhAzei9TIf4MQT6x63LzlOR7jrzrzc4H67s5w1s4bfCdkHgr0Mf
         ZzTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMqpGIehMcjL2VkWBWg6OSd21NVagmn8DN740XMwc++zPvlhY+bw1aRoGSmuRstzHOpNpSHRM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcMtLezA3pqKxocmwVaHSR3N0w7bh1uI7MKdB6/9iUMU/0KZhV
	0YAFvXFF3k5ThXe+A6fRWWCdeKc7A30poVBkm/DfYh3I8HaG0IuO7QUX
X-Gm-Gg: AYBFou3n8Mg7b+U8YKbOzmLKiE2deTAMh5vQTSdgVt8+o/9GdmanZvvqtf3C76wRACM
	qgNToMPfDb/GjyHaZaluO0IWbm0LNDY5tKC/gOsbW5p+FCzeTBr/wMpCT/lHbXQgiUwKZ2HNgok
	ti3nvLd0f2/8faNgHlwVLqYxsvNcwnoWZo3QbKmdkSBpQ43MS5H5gs3nU6qD5Q/HoEctjvw++XH
	Mb0ZwoGbqhG78+kThgPM2lyUgeyLbgv4mx8xbQv9lptrVPW5Cdf1V5AS+sR4Qn2Ia1jFXhVl8e5
	q+ufxZAMa4IeTzWDUxjvxp2y/vx5kaz60PbLtvxZIg/d8Xj9gaRfsqr7ODSS4ZfVcXt3MHjTznr
	JdvaeL3wn9a750IAEJf/7BcXBT1EaxLLKO8BHPbIYIZYuIhIAdshiA6Q113aOaT35iPfln506WK
	3XntlROPkCMS9T1u8I45P/SCC8odkNRtmKkpXqJae9L28ugBls80t4qUO/QvhuGOt4ykEFnzBPT
	YLZ7FQBptfJotwJhzdctdBfd7UGszI+EZ8RJyVor2GYpm2y/2IBpXv9qNMeiS6Iv6xulgNwwYvZ
	QPxDQB3w79oTE6YBVJw=
X-Received: by 2002:a05:7301:1c82:b0:35c:6268:8127 with SMTP id 5a478bee46e88-3674c63d952mr6066086eec.13.1792660022183;
        Thu, 22 Oct 2026 02:07:02 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367416a1fb9sm12794808eec.20.2026.10.22.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:07:01 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: tun: NAPI-frags skb can be freed during a blocked write
Date: Thu, 22 Oct 2026 02:06:55 -0700
Message-Id: <20261022090655.3643698-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

In the IFF_NAPI|IFF_NAPI_FRAGS write path, tun_napi_alloc_frags()
publishes tfile->napi.skb and skb_copy_datagram_from_iter() copies user
data before the writer enters the RCU section that teardown waits on.
tun_detach_all() does not take napi_mutex; after disabling NAPI and
calling synchronize_net(), tun_napi_del() can free the same skb through
napi_free_frags().

A userfaultfd-blocked write makes this race deterministic:

  writer: napi_get_frags() publishes tfile->napi.skb
  writer: sleeps in skb_copy_datagram_from_iter()
  deleter: tun_net_uninit -> __netif_napi_del_locked
           -> napi_free_frags() frees the skb
  writer: resumes copying through the stale local skb pointer

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, on three independent KASAN
boots:

  BUG: KASAN: slab-use-after-free
  Read of size 8 in skb_copy_datagram_from_iter
    tun_get_user
    tun_chr_write_iter

  Freed by:
    __netif_napi_del_locked
    tun_net_uninit
    unregister_netdevice_many_notify
    rtnl_dellink

The already-held local skb pointer also reaches kfree_skb_reason() on
the later drop path, making a second free a direct consequence.  The
first KASAN report stops the panic_on_warn kernel before that second
report is observed.

Allocation/use must be serialized with tun_napi_del() and device
unregister, rather than relying only on an RCU section entered after
the expensive user copy.

I found no matching upstream fix.

The userfaultfd reproducer and full console logs are available on
request.

This was found with AI-assisted source analysis and fuzzing; the UAF was
reproduced under KASAN.

Thanks,
Cheng Yongkang
