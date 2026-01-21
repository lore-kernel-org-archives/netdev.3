Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6803A7853
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024607; cv=none; b=DL3+tF9dxoHWZCEExivFlHsEYO6T1LY85wjPO4dWdnshI/Bdh0Z+3Wl+FK0rhTn5L5wJ/sw+Z7SiDTr6nrB40EjkPD0Q/kNHlRM+NeBlq/S30wke9xlh+kPqD5u85VI8m64kJFoe/whENjfMW2L6quw/nR2q6DifzZwRAf9Gav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024607; c=relaxed/simple;
	bh=w1kKinpt/YcI0gMNgEnS5zXjFDhZKigaZ8h7epYIB8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kET8Eq+HV8y9HeztrV9uzofKJ4E958iGxut3JQGInVN0FdZ1Ca8rIQMqdcm0Yj7H7s9gf/ZrS4tx12a+rYoud3wDvsYUk/e0YEIPjVjV2MIcGX6IHbx0OPVPrId/PrcsGBd2yHeMuJo0KeU98wshcbPtRatu2uuZ/LMuhMlBrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wyIfniBd; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wyIfniBd"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso429179eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 11:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024604; x=1769629404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ry8GpQeL1FNrHjzLhRKtbLVCrSqvGfns+hF1JkeMT8c=;
        b=wyIfniBdxot3ksMrjE0n0bzpL7YvWgg2VvtucR3ENGEYrsK8NAn9JpDTpsNe9pi2i8
         fPJVrUisnvQ1702sS/QjiEUJI7iSOQpyyczAv+YYd74yB1GLixqHOqIrS2bQR/osdAOq
         QDAkBlu5Mu+lAQ8XDbMW58+mUvGm8Ln3lNILTykxaXfEJz1s9zbMDc4EfJw+xyfHjE3M
         Q2DIQzNs3pPN0j5R3XlsHrOzY7A7lpPA0NkhIWY+nGjru1Nn8iGuYDCgU/mnSM9UaLhq
         FUMeq969NlO2nDG1evZsAu1oef+bBWgFvft1VpPmeohRRKp1PsjAXALcIX/XPNFqznZO
         +RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024604; x=1769629404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ry8GpQeL1FNrHjzLhRKtbLVCrSqvGfns+hF1JkeMT8c=;
        b=JI+eN8QjGuR7K28W1aPDH40JIHsI1HHdYOZhe3Vh0or6f9RiykADUCEiNgx7Po6boa
         KeFgzoggOkyfrOZpi1ohASxVaMZ/RIVYiLqCrjf3JNa/tNoBQpttlQmYDhK+hevqPUzz
         IalJcfpl/MluAjcQcsioz6Bw5O4XXZvCKGuBdBKjsPAY8nKRPYqYZ/AcJhYCTQnxxrgq
         XuWlple2Ji0fzge9oeThe/hz57TcCzymsT30PQoOb/e4FKz2bddMjh/AOFPVNHlfFA+D
         EPt8Z+MZsHe3cMFDpXYZ3dJle58hFUHeYif8vZCB/xvc+foQVd7v09KPoZ9Tu+6twJZv
         YHYA==
X-Forwarded-Encrypted: i=1; AJvYcCWs/qEggWJxmMJPiF2hKqxyn8+SByc91vgAfhlxdI8htYUyKeKUO8wdF9iH+kqYQ8CP0ITyaSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzruuSdpVr+AzXh0yfK8IKZFq6/LYHrtv3jfHeH1oN+ynmGvvlW
	+uGsihRxLFBpo0tyXcRfMedd8t7c9vR03d53dEKzb1j671yut++UFeakeszta3GuPw==
X-Gm-Gg: AZuq6aJi9UeGywgWmLSv0oeJXg6Nax9P8/45iGD20fuQDjtyQIThBBMixe3snwvhBEi
	UauUuRkG1eyJz0IEmTc7zu+a8ZU5R3sefJb13aNIXO6jSzPFmT/hlgAaVqPXeFE5VwMgoMVMtiN
	rM86SN8vY8GqNQXwSSCV2nhyn6P6F5uWZ2+xTLzh4uCOFYZKopVK01BIfWHlGmlpXy1+6PzXKiB
	3EQrUlPhtyriJ/ZZJpl6+x+9HYQnjt+I0Rg8sEwo619AT+cFEeXJfSI/1YDkERLrcoaspXNnm0t
	Ilc7pJJMyhVBQSeSv5R73FQPgxmiv9aCcxQaaDKu0sXq09q/el5nwnGah1Z300jrqu1tslVO0b/
	DqTfKGmqADwHOJGlAWKNV67cLv5IvjkaGSBVZ+Xq9e6QQ9jx/rZ+NsDUnqOz5OauSAv3WK/OlOg
	92887d+KPG+m5va/3DL+WgcriB2892ZTZZ
X-Received: by 2002:a05:7300:6da6:b0:2b4:5a2d:80c with SMTP id 5a478bee46e88-2b6fd8fd5a8mr3538584eec.11.1769024602139;
        Wed, 21 Jan 2026 11:43:22 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm25089488eec.32.2026.01.21.11.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:43:21 -0800 (PST)
Message-ID: <cab42321-cc54-4599-aaee-c631082f936c@mojatatu.com>
Date: Wed, 21 Jan 2026 16:43:16 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/7] net/sched: act_gate: build schedule and
 RCU-swap
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-4-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-4-p@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/01/2026 10:20, Paul Moses wrote:
> Build a fresh params snapshot and swap it in with rcu_replace_pointer(),
> then free the old snapshot via call_rcu(). This is the same publish+defer
> pattern used in taprio sched swapping (sch_taprio.c, commit d5c4546062fd6f)
> and in act_pedit param updates (act_pedit.c, commit 52cf89f78c01bf).
> 
> When REPLACE omits TCA_GATE_ENTRY_LIST, carry forward the old snapshot fields
> (basetime/clockid/flags/cycletime/priority) and only override provided attrs,
> so partial updates don’t reset unrelated state.
> 
> Parse entry lists with GFP_KERNEL and explicit error handling, matching taprio’s
> schedule parsing (sch_taprio.c, commit 5a781ccbd19e46).
> [...]
> @@ -388,32 +416,92 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   
>   	gact = to_gate(*a);
>   
> -	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
> -	if (err < 0)
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		err = -ENOMEM;
>   		goto release_idr;
> +	}
> +	INIT_LIST_HEAD(&p->entries);
> [...]  
>   	if (!cycletime) {
> @@ -425,20 +513,26 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
>   		cycletime = cycle;
>   		if (!cycletime) {
>   			err = -EINVAL;
> -			goto chain_put;
> +			goto release_mem;
>   		}
>   	}
>   	p->tcfg_cycletime = cycletime;

You are always using the just allocated params pointer (p) when iterating
through the entries [1]. So cycletime will always be 0 when the user
doesn't specify it. This is breaking tdc:

not ok 1119 3719 - Replace gate base-time action
# Command exited with 255, expected 0
# RTNETLINK answers: Invalid argument
# We have an error talking to the kernel

[1] 
https://elixir.bootlin.com/linux/v6.18.6/source/net/sched/act_gate.c#L402
