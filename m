Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C03DB630
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078204; cv=none; b=r9NY3XXthSBcywpAX0P2sPO7IEv+G0aSTLbA/TDkgV4s+1oXhoYWliVCxsajSMCK6o/256rX7/9hDHG9/pRSPf25gLmKr/KWesx5WAVkHSzAmCctBJ+43csw6oaEFtiBMdhA7UarWm78mpqNarjCxFJ+tdyING6aVPtUmHk8DF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078204; c=relaxed/simple;
	bh=O9d8+1V2J0rucHBl+ZBzjvVZXoVXgmRn59mqXKv+72c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5wH/QpMv1Qwhsxk/FVAf/MoZ+EMQibhc096MeTlWfYaZ5wRgDyQbyNQ13fHqicNedPIgtyBoKh1EP7DURMN1eQcc2E1eBtna9U5hW/sfmQv+DmBBstgC+aVROhsS8zPr22Pm547Gtcz1Am4MNH9wBJdZQ20SMjCV9glzSEK1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-49559189028so69035e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078201; x=1787683001;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ni+tEXrnmoI9M588zIhviMQKNhq0X7FPWOJLdA2LGIg=;
        b=XHWD+4WUjM8U54lK9QYl5cpxfoAbkWHscOL/f6y+c49X2NUg6+dHETTek6Adfe+4xT
         cAkt+Dfn92u38fGIfnvV8DNwRWRsDJdWcQ3GLIyBULV49uswEx4ih1IZkrgsGZGoB1VE
         iWBwKrMof1rOGtoZ4z1saTYBeRkoj9X9QGsa+4Gce8+sDa3mimbRdbLqLsaSmhml1bTV
         svJHgFKuufPPqilK98GSRlMBZCJz7EN9LqMlcxdRpOOVinOLoq05nmWGKWVel9EOTzFF
         Gj93F9/7WJtH3LkPzW8QNHLe35ntLU8b3ZDINhfOC4Gt7BbQGN5s6q6LoF731syEwx0Z
         r/Fw==
X-Forwarded-Encrypted: i=1; AHgh+Ro39pWWTANxtn9zgm3eREcPrE094FFtxO8R0W/I3fw14iVABPOMeuVphhE38lzZctxRNfC5tsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgHP2B2HShUduhPB2HcQM06NPL3S8Ejjl5OEgh74ejkGbBMcM
	VJnYR8XzeAh8opUHaJmup6vMY8G9ZICUlPVyCSOJvIznkyH6rdSBDp5E
X-Gm-Gg: AR+sD11bZ3QXORR2wWdmCexhA+0lROPcIzpWhopWZKey6SRR0/kTR3GNYskXEcr0iYn
	SvVCx0hunzbpCBHK/stJe/HDhdydEQJ/hkLi8d8aCGeQ8YiAQmQMk2YmrdLZI6Ee/mW9tKcSLLe
	+b2nTb0Fd46e8ywQZz7A7GmAg+xUMC1Lc5llqhXJcDacrYhYDb5r2w1u3V8/CB4PXRKjZpRg7zE
	Un7XLF6vlvzKdmaXEQQUBJ21tHmXLOHyE8ea19BIaclxsLmavwB+GNH3jC+imrhEcO+lMi5tnD3
	sQF+59Mmb6qXCk44gbAwTGy2Td8lRxX/F4r2g6oiMYPJ/PN/dPNtim78FYY881jGQ8DGr+aBtey
	1cqs20bQF3JQP8gLt3OobGmKRMgAZt/7vgQlnRlDMfQEhyP/uAtiwvDWGf++o0iFzFXMD8U0vF/
	L3p270jkbzhjZi7VoFmND2UGGBoSHn+Ydn0+eIDbYU6EjVgb0mhFlh/h3aZhFdCHI6uWJSCQ4p+
	pzbckdkkmTlGfa1Qj4Tcx6syXA=
X-Received: by 2002:a05:600c:354b:b0:499:8d9b:832c with SMTP id 5b1f17b1804b1-499a8c7db7emr4888745e9.4.1787078200909;
        Tue, 18 Aug 2026 11:36:40 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610966dsm345549795e9.5.2026.08.18.11.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 11:36:38 -0700 (PDT)
Message-ID: <c3495f8c-cdb2-494d-8f93-11f6bc323976@ovn.org>
Date: Tue, 18 Aug 2026 20:36:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 1/1] openvswitch: Fix CT limit teardown
 use-after-free
To: Yuqi Xu <xuyuqiabc@gmail.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
 Ren Wei <enjou1224z@gmail.com>
References: <cover.1786936669.git.xuyuqiabc@gmail.com>
 <6cb36cfa28844b05919ca7c45c6c2bc812d3dc2e.1786936669.git.xuyuqiabc@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <6cb36cfa28844b05919ca7c45c6c2bc812d3dc2e.1786936669.git.xuyuqiabc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 5:32 AM, Yuqi Xu wrote:
> Packet processing uses CT limit state under RCU, while netns teardown
> frees that state under ovs_mutex. The CT limit pointer was neither removed
> from readers nor protected by a grace period, allowing packet processing to
> dereference the freed state.
> 
> An unprivileged user can trigger this bug from a user and network
> namespace, causing a slab-use-after-free in ovs_ct_execute() when the
> netns is torn down.
> 
> Publish the CT limit pointer through RCU, remove it before teardown, and
> wait for readers before freeing its contents. Keep ovs_mutex around
> individual CT limit updates, and use the RCU read-side lock while GET
> traverses the RCU-protected limit lists.
> 
> Netns teardown detaches the RCU-protected CT limit state while holding
> ovs_mutex, then completes the teardown - waiting for the RCU grace period
> and freeing the state - after the mutex is released. This keeps the grace
> period wait out of ovs_mutex so that it does not stall concurrent OVS
> users.
> 
> The netlink command handlers do not need NULL checks because the userspace
> netlink socket holds an active reference to its network namespace while a
> request is processed. The per-netns exit path therefore cannot run
> concurrently with SET, DEL, or GET for that socket's namespace.
> 
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/all/cover.1784711445.git.xuyuqiabc@gmail.com
> Assisted-by: Codex:GPT-5.4
> Co-developed-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
> 
> Changes in v7:
> 
> - Split CT limit teardown into a start/finish pair so that the RCU grace
>   period wait happens after ovs_mutex is released, keeping the lock from
>   blocking other ovs_mutex users during the wait.
> - v6 Link: https://lore.kernel.org/all/cover.1786506548.git.xuyuqiabc@gmail.com/

Need a rebase now that a few other changes in the adjacent code were
accepted to net.

And sashiko raised a few points again:

1. A preexisting nf_connlabels leak - already fixed in net/main.

2. A preexisting default_limit data race - not a big problem, should
   not be fixed here.  A subject for a future cleanup on net-next.

3. The per-netns synchronize_rcu() concern once more.

   For this one actually it seems there is a better solution.  We could
   split the ovs_ct_exit_start() into a .pre_exit hook.  And then run
   the ovs_ct_exit_finish() in the .exit hook.  The pernet_operations
   guarantee that there is RCU synchronization between pre_exit and the
   exit, so we will not be adding any extra synchronization at all.

   We'll need to add ct_exit_data into struct ovs_net though, as we
   can't pass it between two hooks otherwise.  And the comment above
   the ovs_ct_limit_exit_finish() should explain that synchronize_rcu()
   must be executed between the start and the finish.

   While at it, we may also replace kfree_rcu() with kfree() in the
   finish function, if I'm not mistaken.

Best regards, Ilya Maximets.
