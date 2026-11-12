Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516400;
	b=AIRT34BP4EINPWgoq6cQzu8EKUOQ8kLkMTXcP/nB7YQ6xuHpggymSjzxVBos0Ja0VZi9
	 J/f48tUNKzXyW6394zzeDGyZwSceix7kXPuvFgDkyMSWQ+nqa8TsJqzkYF0mntDw+FCe1
	 Cy6ITIDiUyYKmfp457U5CBcHs+2ZkaA6gMbKX1QtCE9ugYr0HQtnXVRuJi9uimgYyaCvf
	 FluDo9EsEwoLgW17tuQTWVvnpWwonGcFN4PWavB/1NgIzcw9nfM/g4A0RKHqaKHgKGIfR
	 Her42X5IGu510B3OMqndKANsP595R1Mi/J57DmvPZnQ+dx6QwmafUKqP7aVQ3f0CoIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=hz5GQHqAenEtUeQQFEsz4kxYnKJ4ExEV68tpoBxSRrI=;
	b=GcjGBwP9Yu6ejDttm/S9DWNbcf61joaoIKW/GMRLRjnWT+bi2rQ9vUxRW286/3MZkJyX
	 NJtJOGEFO49BxOZlSfKAqaVj6ezuWKX+FnsEuf2hR0DlMmZYUNltLcIjyb/TnCXJm8uM4
	 aExiEMz1jESBx+r8O3aHRf/9Ww2ZRuNcvTX+VNvDNzJ8sOQNUoBc9PJxn2D+vH97fcwQH
	 n8NUpOmAvmsEvkmNY7ZjFzzwrvISoX3Un8jWQDlgCeA13h1Eh42yBpj/PWMcaNCB6Bele
	 iYMmh1V38E+/+Q+lIq1wfpcX3y5F8CVpsN5K0UjXGkWlDETDPqPDJ3xOR2OBR/eG7oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mFRzgcm9;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124E606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C124E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mFRzgcm9
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb9f760337so714129a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794516399; x=1795121199; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hz5GQHqAenEtUeQQFEsz4kxYnKJ4ExEV68tpoBxSRrI=;
        b=mFRzgcm9gmxgGhSCXeOWWlMZxh6O/oOrWZWbR1v+FQMQKnRRf1UHRUyyi0iTJgwD2w
         YcW5jNL9bQLiND4CesLayd/jcdXBv/bzM2Qsh+mYd1T9p3ofQLgd+2l7TjVRuUmSmw+/
         ISf2z21yExELgwU2cOW7LAlXjDBMA7+Kp8i2LhmwzHZs2FcleOz4G0XPUycErEwreF7s
         TYcm9cYzhHzNI40XnUBoK1u0xgq1jU6RabxjObVFROzWGpVOmZleytrXwNzqLZGs6KQM
         NlknNzW+At0SLkdEX0qvlBbELp5LtnoOTpD4nUeaMfpTQvtbjpgwcc3i/ChWejExIIHO
         tF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516399; x=1795121199;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz5GQHqAenEtUeQQFEsz4kxYnKJ4ExEV68tpoBxSRrI=;
        b=Zy8EWrZ/nCq03FjhH7ui3BHTAl1SNw5Ftta68bLDAKRLg5UHuC6jFLjTCuphExFAs0
         g7Zl8u4bizX8UmtS5zyOOENWYDTgrlfLGj2Hk6fvndLw6iMp3EtxccC3L+L1Vi+xIhYd
         6CO2QACWqonSvPo0CJaUVeiaDJ0GJavDMaMbxtCvIoka/URsdCg4RmPYSK7or1hbd4YE
         ktOpDO3V9U/XJUxg7ASHgrwY10BXS8wkcJwZ2UslfiXEww7+L3/jlFsbFUF0ZRmxxp4s
         ZJd91H8KU5+wYv7wovVcxBNOm+8AHCk1SyDtpLcROqXQhZeinuEjA62vLWh+kVfC3OyI
         fw8g==
X-Forwarded-Encrypted: i=1; AL+hErFWoCm7KppIj7FVkxBOiiI7t3/Kv7s6s0pRmulx1zsPzOafIsTHTk9DQzAT6K6j+xRe9zBsjZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TFpZ/nFcGnHAVg8UaK977ZNAxkLaIPOZNVGm3cRn9D5uCoMdp
	/vtjpj+dCsBbG9ekus0LYbGh3Mdqt6IgygC7jlcdgxx7+mO3dEjUMv/I
X-Gm-Gg: AYBFou33/F4685ExdxlLaeTTK+/qgA2UX74QjZo5xZTzpuvl26+MwV/oRbR0CpXbnnY
	+A5hXIv5KDWvjCokG3DXwhgvdA/QV65UWw+hB4zpyzUPEJDCdJMwv+6dSOKd2AliggvcK55BPFh
	TU0Spak0RvJ4SZpCrrNLzVJMFaGdBex0itB72gM8XjTu88DQd7h9ujfgOLFfqm7bkHmqM34WMXj
	v3/HBbXNOTYy01y598jdrVjWS+nqLWsCnmGqGxRIeFonnoL513r1rut86fFIti13QMkw5OviC6b
	2jd6Nq2Hup9CLg2lo+366fuJ69zngBXK++3Lw1Kcm4GyJuJM081M79xWLgWrS7CeGCcy74qrdgu
	A0ROvG0Ed7uZ7ED6wNOa8yxoJnXndQvZ/RDEDfAxyd00v14Qin+1Qa5AuZRzP5Ugjsn117yBuwn
	TfQ4grLacVkJamCoYWJZngm9IL4AIe09d+bDLsNQDKd7OBosOKlyX3vQn1BTt7Fm/EPOVNkL3BR
	zN5P77Q/osUt149cR1gd/OEo2wbBqev3q7xfEfMfxA05nWu0g1DDF01WFrXV+34OI2iqGoTe8Zj
	PQAoVcWArr5aXVf+BRilKJJA7QOKaa4U2A6DTNLp0n4NFbJVMiD3VUrlN+UfZPfF8tm7PUrNVE1
	DDEinofYgIu+5PTV+ZxygpjCBFTB7NsrCZA==
X-Received: by 2002:a17:90b:3a47:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3b1b0d7e539mr149037a91.41.1794516398718;
        Thu, 12 Nov 2026 12:46:38 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm6330400a91.11.2026.11.12.12.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:46:38 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 20:46:37 +0000
Message-Id: <DMTIZ0EMQ6HE.7OEA0L4EX96X@gmail.com>
Cc: <andrii.nakryiko@gmail.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v4] bpf: check cpu_possible() in per-cpu helpers and
 map callbacks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "bo cao" <treebacker@foxmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <tencent_6A1D611E2DA9545DA6E76ABCCA806BC39707@qq.com>
References: <tencent_6A1D611E2DA9545DA6E76ABCCA806BC39707@qq.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 08, 2026 at 06:43 PM bo cao <treebacker@foxmail.com> wrote:
> @@ -133,6 +133,10 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
>  BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
>  {
>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
> +
> +	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
> +		return 0;
> +
>  	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);

bpf-ci is right. All three callbacks have the check.
Drop this hunk. It's dead code.

>  			if (returns_cpu_specific_alloc_ptr) {
> -				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU;
> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU |
> +						       (ret_flag & PTR_MAYBE_NULL);

This is a fix for a different bug. It doesn't need a sparse mask.
bpf_per_cpu_ptr(p, -1) returns NULL on every machine.
It may break existing progs and needs a separate discussion.

pw-bot: cr
