Received: from mail-ed2-f8.google.com (mail-ed2-f8.google.com [74.125.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC518C332
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348746; cv=none; b=cC3gqvxU9b6XvIUoxb/sqJMzy8ry2BOI2jWduYotO8yMFkS+GM+z1ODxcikcmTq4SMRCkCvbmlpevVz5kSVTgzRKfapfK7dmu3pOB1dKGd7m4R+pFFAmeMWGjfW/st4tfWIdSXdiSHCZNej03jAEaaPJcFAZbNBypQCnDIwNLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348746; c=relaxed/simple;
	bh=XJWOALC07zd1MTx2R/9zStBeRTLiIdAazDeHZtufKlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsIzjxsDD55x1ZgT9dYS3nT8+cs4ysvxd4bhyIPA+/Y2Leq5SRoSSwldTqvEo8fxxrV3uAAxb8XjBSdfQt0BVr1hdHaHrF8iF3R5cyJQ2FLdx1NkhWKQtLBdNM5Jsaiqwrn+Avb7CbT/ouWRBoTdUfJnMe2NxvKqGqJ5k3LQJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f8.google.com with SMTP id 4fb4d7f45d1cf-6a18fec4137so785066a12.0
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 14:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348743; x=1787953543;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CagO51GU01dr01lTuGgIuEnt6N6I5+STWWJTUDMHOh8=;
        b=lYS/0U952FzOxJzmqecvVMxOC7IajcS7z4mTRm43FqhSkySJubIrRJ9QTVP6wI7tHG
         F4z+A/7OlsW23fB98gXgF44rrdcKfNnY3mMx+pFHX7l8AuznGRT/pvLjli4/NqCGVbdU
         1CPtPiZYGiNnkzOC+gN12ckixBG82RRXRZE6+2cyJU0M9NF284TeEPmic6UXyg+b0jMj
         2Qv5UK/xIOJyUAQfcr1Niy2X7twNYqEx7HJymDTSM/e3dDzcuk85AMQYV1VjbM/AFiVi
         /SSUwv/FXQfhJxm8sU5gdKcEPS24h1oCqwDXgM9Juf3+NNCFnybDhSKv4XXVCom0tU5h
         s6fA==
X-Forwarded-Encrypted: i=1; AHgh+RphIN4emRCSxCg/JcNABH+jqkHS+qy/fE/d/7XevvdWHfjuTzDFq3wd8TC5k3KLBJU2YhJ0nTU=@vger.kernel.org
X-Gm-Message-State: AFuF++mjiLWsrrvX3KPNryIg4EyrByXbfG0FnrM76L220usAMn/6yQI2
	hWdqaZpETre293KdE1f3QLhrouiCBnTG0wjPHWQEHSsN6oQRO9OTDN5F
X-Gm-Gg: AR+sD13IVdOb67Wm+zn/ipr7xEZgM7CwaZYv3ObM1nNxgmFeDhcu74Tqa6HIUYt8mlh
	+mdfd5ZG4xzwX9TOnJULATHrC2fMQymqzEspVAZff/13lR+OeSNHGQjYV+CjmCp3li+ETKUxwZf
	BF8c/9sCKaZMNhaaEVd7S91ubu7yS8vIBM9rEp139tei0rfaCDMjEzpfSg9qyFZ1GzGArFQUz1g
	vU1G5Jm2EP5ve6uNGLTIBh0ZgHZ48MzVvU3lOD0M7A3qYXqZd53A3Ip5J6uRyVnrfss1eO9qpMF
	Tw04jjUC+llHzdJXtq3bfnoxDCe98Dnm+Ei/5rUBYr0q28b4BWi/YekPOiGCsArrF6IVsS+6Qf7
	L+pRHuSQJ5JVmLL7p4RsiJy48egs5qm68eYm8kCtFlt6AnWXNs0KRi+3KvXBU8Y//jaCuqAI4wt
	7GpfJPKJN6J4ppf7t98/Ivi+M8QONJ+MX+OXsxaG5VY3NteQg/DVWq3baYHJ70/e5ngXK4lLWiO
	gzNc8Bx248fzaFA
X-Received: by 2002:a17:907:d501:b0:c21:9cf4:e1b0 with SMTP id a640c23a62f3a-c246a30a9f5mr1016821266b.3.1787348743308;
        Fri, 21 Aug 2026 14:45:43 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bd8fasm20064466b.28.2026.08.21.14.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 14:45:42 -0700 (PDT)
Message-ID: <34c64d08-0484-4f3b-b61a-ed68115d01a4@ovn.org>
Date: Fri, 21 Aug 2026 23:45:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/3] net: don't strip zerocopy frag markers from a
 forwarded skb
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 10:43 AM, Norbert Szetei wrote:
> queue_userspace_packet() calls skb_tx_error() on the packet skb in its
> error path, but it only borrows that skb: on the OVS_ACTION_ATTR_USERSPACE
> action path do_execute_actions() ignores output_userspace()'s return value
> and keeps forwarding the same skb through the flow's remaining actions.
> skb_tx_error() completes the zerocopy uarg and clears SKBFL_ALL_ZEROCOPY,
> and with it SKBFL_SHARED_FRAG.
> 
> For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG is
> what makes esp_input() skb_cow_data() instead of taking the in-place AEAD
> path. Once it is stripped, a later local ESP delivery decrypts in place
> over pages the sender still shares with the page cache.
> 
> Patch 1 moves the skb_tx_error() into the one path that does drop the
> packet, the "default" arm of ovs_dp_process_packet()'s switch(error).
> 
> Patch 2 removes a second such strip, in skb_zerocopy(), which calls
> skb_tx_error() on its source when skb_orphan_frags() fails. A copy helper
> should not perform a destructive action on its source, and both callers
> already report the error on their own drop path. MSG_ZEROCOPY skbs cannot
> reach that one -- SKBFL_DONT_ORPHAN makes skb_orphan_frags() return early
> -- but producers that do not set that flag, such as vhost-net, can.
> Patch 3 is new in v2. It stops skb_tx_error() from touching skb_shinfo()
> state that is shared with clones, so patch 1's new call site cannot reach
> a live skb either. For a non-last OVS_ACTION_ATTR_RECIRC action
> clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
> do_execute_actions() keeps forwarding the original, and skb_clone() does
> not privatise the frags for these skbs -- skb_orphan_frags() returns early
> on SKBFL_DONT_ORPHAN -- so a flow miss on the clone strips
> SKBFL_SHARED_FRAG from the packet still in flight. Confirmed on a KASAN
> build with a flow matching recirc_id 0 and actions RECIRC(1),OUTPUT(0):
> with patches 1 and 2 applied it still reproduces the page-cache write,
> with patch 3 on top it no longer does (5/5 runs). A kprobe on
> skb_tx_error() shows the datapath drop path is still reached in both
> cases, so the difference is the guard and not the reproducer.
> 
> As Ilya noted, that makes patch 3 the general fix -- an skb can enter any
> skb_tx_error() caller already cloned elsewhere in the stack -- while
> patches 1 and 2 keep the callers from acting on an skb they do not own.
> Removing skb_tx_error() altogether looks like the right long-term cleanup
> and is planned as a net-next follow-up.
> 
> v3:
>   - patch 3: Fixes tag corrected to 25121173f7b1 ("skb: api to report
>     errors for zero copy skbs"), the commit that added skb_tx_error()
>     (Ilya Maximets)
>   - Tested-by from Jongmin Jang picked up on patches 1 and 3
>   - v2: https://lore.kernel.org/netdev/AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com/
> 
> v2:
>   - new patch 3: skip the shared skb_shinfo() work in skb_tx_error() when
>     the skb is cloned, which also covers the OVS_ACTION_ATTR_RECIRC path
>     that patch 1 alone leaves open (suggested by Ilya Maximets)
>   - patches 1 and 2 unchanged, Reviewed-by from Ilya Maximets picked up
>   - v1: https://lore.kernel.org/netdev/8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com/
> 
> Norbert Szetei (3):
>   openvswitch: only skb_tx_error() a packet we are about to drop
>   net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
>   net: skbuff: don't touch shared zerocopy state in skb_tx_error()
> 
>  net/core/skbuff.c          | 10 ++++++----
>  net/openvswitch/datapath.c |  3 +--
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 

Unfortunately, this needs a rebase now that a conflicting change
for skb_zerocopy() was merged:
  https://lore.kernel.org/all/20260814191336.187243-1-almasrymina@google.com/

Best regards, Ilya Maximets.
