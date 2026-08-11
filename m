Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50447446073
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456574; cv=none; b=TTJAPtOe2qu2J0CP5sgtAJcl2ixg1uXZ/oCEoWNTUDU4604LFSRG3VyG+IXIAoPRkLdthSVCGQIGCEkE/hA3SNzQwaj8VsmbU+7y1lDSIZ6QGVA4CpHk/GhFaNkLejJyKQzD1MunDZ7OQPxaw3HmwjDf0tj//PKwSFASUcD7+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456574; c=relaxed/simple;
	bh=mPX092SAxdnLkN/6z9ICmIXNghJissgSgQYrcMNDQ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwG4PRhNN/mpnGw5J547FksA1MuvLWptA6DLT6PHV6+YsGOz71TofUTpXVVpEp0M1vAN1wLKHGzwcuhxDfWuMWXGohGPre8NXY4TyBzB53v3jnC6GXpPx6c2KyRmfOPXuZAdm30kgZmGhjKc1KDhw/HOk430Vk02kB64tIRMq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC4Agfhz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC4Agfhz"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4731f5ffa74so254939f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786456570; x=1787061370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKydGfzalUMU8QK5vpmVMtplqbkcNF1gUk8nxhRQcp8=;
        b=hC4Agfhz5Fswem8ScJFdVM4gJwnPSHTmKttvqDNjs17JbasXU6MgP5FMLKtikGQcTQ
         W00rejijq+UNJHL9I5ljJfNUQMoNztMne6obQ864gevr09FEbkwIbH/gpmLKTbizDFPs
         f0YgQVwE84lqlJYd2U+E7f/yxFKtBJEsO0d91CvCFqKuRE91WLgOa6rfmuxAb0uP0J2F
         cpd2RjApUAnbv99iyJnjZ/bDXH9n7ab1UkTs/EAcCDgq5w4aMy69Psm/KoPBinvnlle5
         juqil1UXck2zieKh/vfEYGQwo7XORBvS9oewHO+CXXTND0BC3puzu3aR8Fu+0VBSdaqW
         QIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456570; x=1787061370;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKydGfzalUMU8QK5vpmVMtplqbkcNF1gUk8nxhRQcp8=;
        b=pFfCYKeyMeB8viXuHtU2TULzLGVdK7tsjzVSX/JD9FItlzL6e+rDC4XXO6I0JUzlYQ
         BmL7VDhmQ/Mrxnu5/qRrJCR9IL5HrOKAkMYV79UPNu6BdlkD/tRwKe5IatNmtVuDaWed
         n30x8ZkNIWc6Fe9M63FhRdK1kDP9pnW9bhYBEBpx0/F/ietxycnkAo4xTVfRWxE2vZyL
         SimQo4HD1vdWVs4JCVrVlp5Sz+yXrFAYC9pKGl/kb3cvzOWgVI/tk+nDUdNUxzMTmA4y
         uyMjMCQ5zjzcmvf+rdbshY1kYojTaJ8wIUr6CdiRuY1TlHOAEW9lXZqMVi5CV1rYUGdZ
         Otbg==
X-Gm-Message-State: AOJu0Ywpyxtvbei6TSvWKnZWzh78zELMN22+buAZ+CGav0QCrf2IESDA
	JEzibFQ5Iuk5q/O8ijyNzMFTBTsPw3CONZhYydMf6+K0xlBc/6Xw6Mb7
X-Gm-Gg: AR+sD10W/NmmO15r+x9fHqizpljmMRNVS8SoRJU4p82U6HRNV5tZBCHvc1AGCLMelpk
	hqDKBMHyYZqRdx/j0gC1TrbOaPIEfmoCnw5Y2utfgwUxDpnq9ebcRRcGBAmOmYxd0s08i0FQeHl
	jaFghw9WnrLO+wwm0TikvvaTbHVsaUAm5xi118MHurRd2YNYGq2I0LALuKaOXTpauOmRqJ4zGyC
	mWRnJewzqbd4y8xwXbg9XbXQdXoAomywgHuVaZrBBcyALgpUdURtMwA2cjA8mwx7z44UvQHFPF6
	SjV+gBvEZM9xoi3mB+bu7+MPwSYtAGF9GeR/b6mlc/7JP75bqSaHr1Lxoko11oxKgBBOkQEoo1Q
	dhyjbm1YpBPjybAu1MeZpE1xIxnHOk6vlBykUY64d9pm2S6b10FiDMi9nI0M1h9LmheCumbkgB2
	/SGKtb/YLWrPkxYvDJtSoZuSFPZJ4H8i5kZn4bvcwBgQjCu76UjDttXb1JJfl5TTTJ/EHYb7Qyv
	n5djkJxfP4PX0vU661apb77ohHdssGWFvCaDbnaeCE862ytfKgh34KjyS4+yQyYaNoEBH2xRuAo
	B4Jkk0PUbygP
X-Received: by 2002:a05:600c:35cb:b0:499:73ca:c419 with SMTP id 5b1f17b1804b1-4997846a357mr36107395e9.4.1786456570151;
        Tue, 11 Aug 2026 06:56:10 -0700 (PDT)
Received: from [192.168.2.69] (dynamic-077-179-054-188.77.179.pool.telefonica.de. [77.179.54.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499793ce27bsm27603255e9.3.2026.08.11.06.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 06:56:09 -0700 (PDT)
Message-ID: <063eb98e-95d2-4d95-9720-08b351fb6e6e@gmail.com>
Date: Tue, 11 Aug 2026 15:56:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hsr: free learned nodes on device setup failure
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 luka.gejak@linux.dev, kexinsun@smail.nju.edu.cn, arvid.brodin@alten.se,
 linux-kernel@vger.kernel.org
References: <20260808110814.1637-1-xiexinet@gmail.com>
 <ankqCHe8D9y09aN3@fedora>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <ankqCHe8D9y09aN3@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/08/2026 03:31, Hangbin Liu wrote:
> Should we use this fix tag? The proxy_node_db is added in
> 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)").
> 
> Thanks
> Hangbin

Thanks for checking. I believe 81ba6afd6e64 is the right tag.

The demonstrated leak is node_db, and the window that creates it was
born in 81ba6afd6e64: that commit moved per-device RX handler
registration into hsr_dev_finalize(), ahead of steps that could still
fail (the second handler registration, self-node allocation,
register_netdevice()), while the failure unwind never released nodes
learned through the already-live handler. Before it, reception used
the module-global dev_add_pack() handler, which could not reach an
instance until register_hsr_master() at the successful end of
finalize, so there was nothing to leak.

proxy_node_db cannot hold entries on any current finalize error
exit: it is fed only by interlink-port RX, and the interlink add is
the last failable step in finalize. On this path, the second
hsr_del_nodes() call is a harmless no-op on an empty list, keeping
the unwind symmetric with hsr_dellink().

Using 5055cccfc2d1 would instead keep the fix away from older stable
trees, where the node_db leak does exist.

-- 
Xin
