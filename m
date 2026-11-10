Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323275;
	b=XYo28h4syUusIt4OQwRGPX8cKXZdzwzNeg5N/PAaLlC1bZ4v46WoUrHN6keoY1/2CU2V
	 Txgeo3l0t+78HbhpMceVqguZAvUDs4wl3DLMmfd92C5h2buZ4aDv3dJt9gV3RkrYbZy7O
	 A/sGiQ8vYWEbErF7v0HSeU6D/e0uMStgbz6z7bCMHDAS83miDtwgUlG3fFHULvb/g4sXf
	 PbNyaSSJlemDMqh3Mrs/P9CdCO801omOnGeoiYbSQX4LpkQ9DB8Kq4i18ICoK6N9wr0iW
	 vG7HGc5LR7wIc1ps2ydaSN53YBwaW0e7X/kAlPpFcehiYsOVk6mME2MDei+Uiyzbhdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323275;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JV0KNSel6SKgbZeXZt1zs0TVL0t1edeqY8eeYRyb93I=;
	b=gqPkp/eOKnkqXxjUzGEH7mwuYUN5WbHXHLgkPf4LMaGo79edvHGGQQ59dHe1TvBQAi2Z
	 l02PrnIjHS7/mN6CV48SgxNHGSPoGMm61eG9s7keyCYpABLMSU46BESot4bpRT81pENEi
	 5if1cltJNZSkOs/KqSby6zijPesSW6mz3aGAFc1hetzpdupGjBXKq5LlnDiBQ+DKaU80c
	 EvpeBqauYQylXIzXDPn6vDPgu3MFNus4emkwVy2KFu4hoy03WY4dKeMagEcneKH8GAoxl
	 jLHWH+ETO99DkYq4rtTPDvijFkCtTRAH9+yUCQf8GoBRwh3spbrLcSL0iChG3jkmg/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JSwI4hyJ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gyXOXHzh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CC606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E01CC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JSwI4hyJ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gyXOXHzh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794323274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JV0KNSel6SKgbZeXZt1zs0TVL0t1edeqY8eeYRyb93I=;
	b=JSwI4hyJdAUrJfLx1RI/KToAiPSLh4voE16QrLj0lEx/YSYbuDa2W3wyI/xjYLQO7dUzcH
	3zyQkWod9EsVc/P05SCgIATGXN/rTYgMPma9yJRYROt3WBy5WK2MNa3+CJtjHcmoGZSsvW
	RPsFrNjUTEEdKPYpYBKKftApQtr3DYA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-aDOTN_sHM3OZsLMC1J3XIw-1; Tue, 10 Nov 2026 10:07:52 -0500
X-MC-Unique: aDOTN_sHM3OZsLMC1J3XIw-1
X-Mimecast-MFC-AGG-ID: aDOTN_sHM3OZsLMC1J3XIw_1794323271
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49205554e17so1423342f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794323271; x=1794928071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JV0KNSel6SKgbZeXZt1zs0TVL0t1edeqY8eeYRyb93I=;
        b=gyXOXHzhRdl98gqxXdkfmT+bovA4tkIYVtUwXBiZpo6AYBJFK9HnDLrVl04b3zZYEf
         4/tTffVkWYlFvh/EwmMUNrqjg8PeeBZtGzXNYqrnZobkH+hlgx5ZsjgQ3cvKYkNoYdD+
         teGXYzp4k2V3GRG+EHSKZwyjg1ILyhKacBrHxWXKlSLqWG5CguusIhKJ8ebxNiggTLbz
         aJ2nxDyUY+YVolsedUp4K+uKUi4QQPnl1MP3qEBCJR3+l85vF1oKkC41+BF7Q/lCut2P
         ENiqSblsdswmQA084oJRNe8LP3NOF4sJ5N3TEi6jZ2dKTUB+ZpRTRsbdhzGRg8SRjzH4
         P0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323271; x=1794928071;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JV0KNSel6SKgbZeXZt1zs0TVL0t1edeqY8eeYRyb93I=;
        b=sfh2PCa4Nzh6oWW+ws4EigFwAIy6/BmfHMkOPMKUjcbWMk116fAQvyGeXqv04ZgCu5
         oTjtuY+E95Gdicpf6rCBBjX069HWTU8XHOziLR/Isb/hgLQ6s3D8TD4rFs8myFL+g/C2
         Jjkbsk61xrmPJlJ/pNJSKjhIsnB/TD3rFrOCUWFS9WEHmLlGTy8PmGHoP4i1yiqq2eH0
         NkkMomsM4V8vN0CvnW58AacjGs9MneeA/0IydcivZzaKHuHFYHKDuoFqMmjvIb5elAAJ
         3us51iGL10jBkMGQZz3s3qKZS3fw01/CF++1SI/YShzBy7kBjb1cW+Lw9dwXg8bxnmxc
         vHkA==
X-Forwarded-Encrypted: i=1; AL+hErHC1SBjPuFtHnMPVsOyGJWiKZe3Jxpstyn7u1SfmEg+rXSDv1/gyjpNmaUA7mcHlnczcjLl/8g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NSMZHMhtgbgYxkDm80Z3kXsNhc45neyI+fA8h2jXxTK957MOk
	Ml90uEqYQDejssG7bD5Hz/HDWSWNmetsER9xKnPTEy+a7ewWshFbpmRmUVbc+zMLoL4fcbzJKwR
	KIhSw/me4t/T9mNF+h/gMEfHAKvX0KIsyX8s4MSeQYWCyDnVPLxRl4XLmRQ==
X-Gm-Gg: AYBFou1cwwpVw/esxY0S3evO4UPRpvDxZr/fJiCrLS9WCYyi2AAZ2OFdF1S+idY9i9p
	eW4oPdL/Da0DBV0ugLNoVDoiqGS0QFjUaB/MAlyCTiMObTBo8hbjXt1g9rN5YTwyH8emKCy/d3y
	NSXuRJ3nrIOXxm5F0DaKGroBCg6LpDbYqvk6OGpVgJqd9ctkqbvjxYuC6R0Gya6seHsaF3+SHmy
	K/xfBHqFtpT3zUI2tCyxwCqrMKOavrULOkVHTZ6gVx7bUYCDkCcpLqlAGtX9Pj1lIsXmG5IkBaV
	jKOdwYkoOjGF3qw+EcKUybWfY9CoN6zsbRF2ACStn6I02Pjud4Kncv1CRctYbfKpwzXK2A8xLPB
	oQbj+ktuhCHqXtlqDE5rTo2z+d1c5yaF6zKLeBYo7jQ/waKmsOVR60cG+nemJiB8m8kOxAs5V0+
	S51cxnNu2cvBvO3ExmUsoe3aggXXg+fVE9usjDxFFzPhYN
X-Received: by 2002:a05:6000:468b:b0:48d:f237:df09 with SMTP id ffacd0b85a97d-4982f873ab6mr3801026f8f.21.1794323270735;
        Tue, 10 Nov 2026 07:07:50 -0800 (PST)
X-Received: by 2002:a05:6000:468b:b0:48d:f237:df09 with SMTP id ffacd0b85a97d-4982f873ab6mr3800986f8f.21.1794323270236;
        Tue, 10 Nov 2026 07:07:50 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835e20327sm5785813f8f.26.2026.11.10.07.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:49 -0800 (PST)
Message-ID: <2013be48-c57c-4b4b-82d3-8511842b6cdb@redhat.com>
Date: Tue, 10 Nov 2026 16:07:48 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sched: fix cls_flow SKUID/SKGID userns mask
To: shaos <shawnq1@163.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <6AEA1AAE.2E7978.08739@m16.mail.163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6AEA1AAE.2E7978.08739@m16.mail.163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 18:32, shaos wrote:
> Hello,
> 
> flow_change() checks FLOW_KEY_SKUID and FLOW_KEY_SKGID as bit values,
> although they are enum indices and TCA_FLOW_KEYS is a bitmask.  The
> current expression tests bits 0 through 3 instead of bits 14 and 15.
> 
> A process with CAP_NET_ADMIN in a non-initial user namespace can
> therefore install SKUID/SKGID filters despite the user-namespace gate.
> Those keys use initial-user-namespace credentials.  If another user's
> locally generated traffic traverses the attacker's qdisc, the filter
> can expose a property of that UID through class packet counters.  The
> same typo also rejects some ordinary flow keys.  The demonstrated
> cross-namespace inference requires such foreign traffic to reach the
> attacker-owned qdisc; this does not disclose an arbitrary UID or grant
> privileges.
> 
> HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
> Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
> Source version: Linux 7.3
> Compiler:       gcc 11.4.0, GNU ld 2.38
> 
> The console log, full kernel config, and reproducer are available from
> one fixed-revision Gist:
> 
> Console output:
> https://gist.githubusercontent.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0/raw/b3acb75e61d1cb703c7488ce0400651cd8c84b16/console-output.txt
> Kernel config:
> https://gist.githubusercontent.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0/raw/b3acb75e61d1cb703c7488ce0400651cd8c84b16/kernel-config.txt
> PoC source:
> https://gist.githubusercontent.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0/raw/b3acb75e61d1cb703c7488ce0400651cd8c84b16/poc.c
> 
> Clone this Gist and the exact Linux source revision, then build the
> kernel with the attached config and run the PoC as PID 1 in an
> initramfs:
> 
>      git clone \
>        https://gist.github.com/shaos26/a5571f1bfcd37c68c7270d296f1c12c0.git \
>        cls-flow-repro
>      cd cls-flow-repro
>      git clone \
>        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
>        linux
>      git -C linux checkout c03c1a14507dfaf8b856c2608f9ac216021fc222
>      cp kernel-config.txt linux/.config
>      make -C linux olddefconfig
>      make -C linux -j"$(nproc)" bzImage
>      gcc -static -O2 -Wall -Wextra -Werror -o init poc.c
>      mkdir -p initramfs/dev initramfs/proc initramfs/sys
>      cp init initramfs/init
>      (cd initramfs && find . -print0 | \
>       cpio --null -ov --format=newc | gzip -1 > ../flow-oracle.cpio.gz)
>      timeout 180 qemu-system-x86_64 -m 768M -smp 2 \
>        -kernel linux/arch/x86/boot/bzImage -initrd flow-oracle.cpio.gz \
>        -append 'console=ttyS0 panic=-1 nokaslr rdinit=/init oracle_uid=424243' \
>        -nographic -no-reboot > /tmp/flow-oracle-positive.log 2>&1
> 
> Change oracle_uid to 424242 for the even-UID control.  Run the same
> command with the corrected-mask kernel to check the fixed behavior.
> 
> The vulnerable kernel accepted both restricted filters in two fresh
> boots.  UID 424243 produced a 7/10 packet split between bands 1 and 2;
> changing only the target to even UID 424242 put all 17 packets in band
> 1.  The corrected-mask kernel rejected SKUID and SKGID with -EOPNOTSUPP,
> accepted the ordinary SRC key, and showed all 17 packets in band 2.
> The fixed-kernel harness prints ORACLE_RESULT=FAIL intentionally,
> because its predicate expects the vulnerable behavior.
> 
> The guard was added by commit a6c6796c7127
> ("userns: Convert cls_flow to work with user namespaces enabled").
> Use shifted enum values when checking the TCA_FLOW_KEYS bitmask:

The changelog is not really suitable for inclusion. Please rewrite it
avoid colloquial language, omitting the whole repro stuff and using
imperative mood consistently.
> 
> Fixes: a6c6796c7127 ("userns: Convert cls_flow to work with user namespaces enabled")
> Signed-off-by: shaos <shawnq1@163.com>

We need a real full name in the SoB.

> ---
>   net/sched/cls_flow.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
> --- a/net/sched/cls_flow.c
> +++ b/net/sched/cls_flow.c
> @@ -433,7 +433,8 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
>   		if (fls(keymask) - 1 > FLOW_KEY_MAX)
>   			return -EOPNOTSUPP;
>   
> -		if ((keymask & (FLOW_KEY_SKUID|FLOW_KEY_SKGID)) &&
> +		if ((keymask & ((1U << FLOW_KEY_SKUID) |
> +				(1U << FLOW_KEY_SKGID))) &&

BIT()?

>   		    sk_user_ns(NETLINK_CB(in_skb).sk) != &init_user_ns)
>   			return -EOPNOTSUPP;
>   	}

