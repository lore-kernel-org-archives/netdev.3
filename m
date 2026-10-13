Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364A3B14D4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880642; cv=none; b=RbR0JNylyjydL0Elj8b7oJLX++f5OPvcCCBAT3aQVkI2lYgaRdluEEmoV5NH+JY2hLizpzgBxJH0wkEu52D8Ze/AT0OmciDUBXkZ9q8l2i8MSjkN2isHyRBF0K6PJydr74G6t8dxqW97EdYuabne1X+l1nVFP3/0K+HlF1R5tNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880642; c=relaxed/simple;
	bh=kQdgKCLFLVuPb1JI2oT1ioA94rfP+HiboMCdO1vaKQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mu9tUoSaRn5POTmO+Dk0Yv+8qW2QB4kKT/aftCgKTAuduLEsgAOQ3u3jkrsdOPp+IdV3jvJPp2XT/jqGfbaylxcCSpTgSzD68NN1rFSqr0pbI+/+cwW5Nzy7bpbzac0T4K++qdz7RBiDBntycypcyePg+0D2ikwece99e2M3pE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWJ0Vi9R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkEwObws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWJ0Vi9R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkEwObws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791880640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JjvUxsCVY6BWug23GG9ZxyGY4JZuAod3S4Z36VB947k=;
	b=TWJ0Vi9ROLNzVEHaWwyDJiw/IhRrHfJlZzYgGWCbhPX1KKu/61+Y7oC6DfQWX1JY+Y062w
	VVtDLTx1tT9U4/v1vKSCesq5TXeOfU6e8YTKnCr/mb2zwAPXnsSS5XLwQeqe4Svq2BMGM+
	tFs+YNohe4zVPYHaEHaAk85nH2p7pmo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-KuscbsxuPPOnuOXDMg-EkQ-1; Tue, 13 Oct 2026 08:37:19 +0000
X-MC-Unique: KuscbsxuPPOnuOXDMg-EkQ-1
X-Mimecast-MFC-AGG-ID: KuscbsxuPPOnuOXDMg-EkQ_1791880638
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c251c140b41so217867266b.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791880638; x=1792485438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjvUxsCVY6BWug23GG9ZxyGY4JZuAod3S4Z36VB947k=;
        b=YkEwObwsSg89YNIIeDqTzhZn3r4hUodbH6hRUi0J16gwkWzk8t6KkJqmv8bsQiMvJy
         iDDwe5So4CkO5p0Y2BLJHTntgaU5Dc8lms8aLOneZNkzZHn0DpiV1OTxsNpVQzDoOYbU
         8e6q9A/TRMl5/K9qqbbFvHPmqSRbDw9Q+BaFupSa5HnDVOYLPIqW591tszUObDYx5ZU1
         8PS97DBeGwktIvhTiLhlfovQvaZ3tWus7GQ9ZYRUKNXHjka/DEOLypHMrbvrWeQu845u
         Lq+5gDhTFkNsbpUkLnQbepMtrlLszaZEANITkI4seVaH21r2GzZRXNcUkqB1UGwEmDPv
         0M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791880638; x=1792485438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjvUxsCVY6BWug23GG9ZxyGY4JZuAod3S4Z36VB947k=;
        b=XLljUAtgIlLoNLvTYgKkpJnarxaGClqo/k5lUx8WKItp8vBf8lQt32VJFBCDN4lN7J
         TTqH3ZOOna3THAO9MWr2A62vx4kmxJzHJyjUOcDUk0DxcIsLXk5HZLvoCvmJ6E417GTI
         JTQtMa/AE7e64mlMphtICalvoDzy659cCNazpGv4QlCHY6nS4krrCLCmlWgcQiMrFNtK
         mo/gzTOEnSV94jcKh/sqI5waUCbYR9sR4vkaq/z6zIkdmGfYeh1IK3FPu6ikFoAfBxxS
         j9qAZVlccBo59rtW/TsfpWK6aZjH7G7youSomUwlb1M5ode0WwVdLpJO2mhfqYfkOiSY
         cM2A==
X-Forwarded-Encrypted: i=1; AKwUvBz89909i7Qd7ij4fDlCnN5ithOUirRuZHYnkuzbODaEPnf1Taca3QZOgw7WmuVeug0PuZGnmSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQdkBWN74MRydSeR6DRh8jVDxrTFH2jfVrXQB+ExjDCTH0CbJ5
	OBR3xbnbjO+NLEk3ZS6KJG9G9W0EgOg4y40tMXmGFIv9y9dgDEIewG/XeIO+jebgKulUnwe5wY0
	6pad+7Ry7/9swm2pxEstDc8LzUPJQcyWQm2dBBZlgeUU3mEavPzG8EpQwiw==
X-Gm-Gg: AYBFou0Druo+SbEmPHm06a3KTnouxs+9LHggm5AsrymSfjQ6ZEr70MeEE7CmsogUgRC
	c2UWzR0LtlllmRnFIUwXW+7kNUoE2+tZ4xikCK9pyzvHHmglbaA5yKmvtrIdQ8HzRIhnLfodcXn
	TXL3DWXSjIqO+kPjZPHq3CckoloQj+jOokK3+ZwzTmt9BsCYz1GyJn+Gs3M1VbxaLp/0XDNZgAw
	SMwy9ji80d+cSEC8fkVxsyGU1bDluG/RPBdEkCQBsWo1/5mnri7llhj/gD1NLPxpgVoc6pYodoB
	KKQ+C6BKHP4v2MSobrou9OxICpVcete/Wy3/erVIJrRZnzbec7rJfetdLbydhubrgcJdh8RbM8H
	8cnIjp8n8SqrT0rlmHy5m2QF0STVpYNkOd5EbKqmU61444IgFYhRuo19e4tHAwWVz6YEjxV124Q
	==
X-Received: by 2002:a05:6938:a081:20b0:c37:8ccb:9b76 with SMTP id a640c23a62f3a-c378ccba7d1mr16563966b.40.1791880638027;
        Tue, 13 Oct 2026 01:37:18 -0700 (PDT)
X-Received: by 2002:a05:6938:a081:20b0:c37:8ccb:9b76 with SMTP id a640c23a62f3a-c378ccba7d1mr16562366b.40.1791880637620;
        Tue, 13 Oct 2026 01:37:17 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ae908esm558360666b.86.2026.10.13.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:37:17 -0700 (PDT)
Message-ID: <96105752-63a9-4123-9835-3912c5c6dd37@redhat.com>
Date: Tue, 13 Oct 2026 10:37:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
To: Tung Nguyen <tung.quang.nguyen@est.tech>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
 jmaloy@redhat.com, horms@kernel.org, tipc-discussion@lists.sourceforge.net,
 Chengfeng Ye <nicoyip.dev@gmail.com>, kernel test robot <lkp@intel.com>
References: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 07:21, Tung Nguyen wrote:
> tipc_node_write_unlock() releases the node lock after resetting n->action_flags.
> This creates a window for several race conditions:
> 
> - A race between link-up and link-down events can occur when the
> link-down thread is interrupted before removing a publication from
> nt->cluster_scope, and the link-up event inserts a publication into
> nt->cluster_scope.
> 
> - A race can occur between a tipc_rcv() thread that adds or removes
> publications to or from node->publ_list and a node-down thread that
> removes publications from node->publ_list. The latter thread traverses
> node->publ_list without proper lock protection.
> 
> These race conditions can result in various use-after-free issues.
> 
> Fix these race conditions by:
> 
> 1. Holding the node lock during link-up/link-down and node-up/node-down
>     events.
> 2. Removing the node lookup and node lock from
>     tipc_node_subscribe() and tipc_node_unsubscribe().
> 3. Holding the node lock before calling tipc_named_rcv() from
>     tipc_node_bc_rcv() and tipc_rcv().
> 4. Moving tipc_node_broadcast() from tipc_nametbl_publish() and
>     tipc_nametbl_withdraw() to tipc_node_write_unlock().
> 5. Moving tipc_node_xmit() from tipc_named_node_up() to
>     tipc_node_write_unlock().
> 
> Fixes: 5405ff6e15f4 ("tipc: convert node lock to rwlock")
> Reported-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> Closes: https://lore.kernel.org/netdev/20261001182924.3928331-2-nicoyip.dev@gmail.com/
> Closes: https://lore.kernel.org/netdev/20261001182924.3928331-3-nicoyip.dev@gmail.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610060355.bPzTfoXZ-lkp@intel.com/
> Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Sashiko has many comments, and this is really way too big for
a single net patches, specially this late. The above list already
hint to some possible split, please convert to a small series.

Thanks,

Paolo

