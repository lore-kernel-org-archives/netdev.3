Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002C41DE12
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662216; cv=none; b=Qip6e+eeggOwLMQGfDKwovoaJcv04QVmHyXjWaatfLyFphZyUzNRy2LOuTkdzEG48awsXog51XudDMoqhIDhcltHAhv9pFbGv0ahMiQ1EFLbjKhbwgiSbR8jfyvXcB/iIYpg0UIq+1kyk46oa5vnE7e+MPvxl/Z4t1fw9Y7aaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662216; c=relaxed/simple;
	bh=x5T5KWr2ObwmztwFUGvjFKm0ceaQT7bcYkAo85qW/Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXqiCL6SUxZMtC7FxLNTu57m/y8gTkGUZOP2Tc5u5NL9+f9pB+yKnnXohBNpvT8BikcqgXOzArr19NRqaudeZCUt3XZzHfaovw8Hscinbfg/QqnRhpREQlGgJ51OQdtEm79aUKPsdm6JApt/+4TlX24pjvcD3mjaCbehQg/iV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=kvWG3W2s; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="kvWG3W2s"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EDB65403E4;
	Tue, 25 Aug 2026 12:50:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 49A8C20010;
	Tue, 25 Aug 2026 12:50:09 +0000 (UTC)
Date: Tue, 25 Aug 2026 08:50:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+6d2762674103618994b0@syzkaller.appspotmail.com, Peilin He
 <he.peilin@zte.com.cn>, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH net] net: icmp: avoid invalid transport header access in
 icmp_send tracepoint
Message-ID: <20260825085052.72ce4878@gandalf.local.home>
In-Reply-To: <20260825084551.1562967-1-edumazet@google.com>
References: <20260825084551.1562967-1-edumazet@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 49A8C20010
X-Stat-Signature: 8panb5jetfphp5ry5tecpj1b77d68a7q
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+bsH1VAQ7YdncMcD1NsdDAgxEyiBWtRaQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Lm3iYBOIFK7L8PlGnFy80nUcg5/loKIg/BpNn52F+9Y=; b=kvWG3W2sj1GWUHeFK6a3M5KEMLF6hHwjpDeAhyTHmJ0RbxdNQ/GDzmZqkE0yOl3dJBtx7zkQ3m8XGeIo66EiE9rRa773nPJzvQEThr59JU2Ec3jDwY9Wh0Ajy3g1mkarKN5IYAglvcGchxbFLyllOJ5bRqTgghEjIFVIXd7tVlY=
X-HE-Tag: 1787662209-880779
X-HE-Meta: U2FsdGVkX1+HdIp3cjecsgeAGLt0d9RUNyURuem70pMkxhkPGuEt+0qY3MIy8/uu/12IRDJA+h41cZEijFy6uNVcQ1m/XbmeNK389ZKpIzm4sendhReOtdSCWxKqpe+yDi92caXghID2Xr5Ue6987/alfnpSu3J/dkQ43rhPfmrufSp6aU+GrCUK36CdZMy5zGL3ihZMB23+4mJGPOWC5+WdmiD/tLY01Z9PKHs4N5Tvful1gbnKSsMWl0VFHl5Nv5dIXyZSvL2FPriFt3t25HEgoNaSF6SHnvbH1wa2uqVPydFNlj3rXCnsp2FW2ZtO1RM3iKWrkCkSmq3wwS8FHBIl0ZS0MsNH

On Tue, 25 Aug 2026 08:45:51 +0000
Eric Dumazet <edumazet@google.com> wrote:

> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> index 09ae115099dfe25616b6c74d5b92be1af4acff55..6937b778ae54dbf4442b127957a017da3551aaff 100644
> --- a/include/trace/events/icmp.h
> +++ b/include/trace/events/icmp.h
> @@ -27,17 +27,20 @@ TRACE_EVENT(icmp_send,
>  
>  		TP_fast_assign(
>  			struct iphdr *iph = ip_hdr(skb);
> -			struct udphdr *uh = udp_hdr(skb);
> -			int proto_4 = iph->protocol;
> +			struct udphdr _uh, *uh = NULL;
>  			__be32 *p32;
>  
>  			__entry->skbaddr = skb;
>  			__entry->type = type;
>  			__entry->code = code;
>  
> -			if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
> -				(u8 *)uh + sizeof(struct udphdr)
> -				> skb_tail_pointer(skb)) {  
> +			if (iph->protocol == IPPROTO_UDP)
> +				uh = skb_header_pointer(skb,
> +							skb_network_offset(skb) +
> +							(iph->ihl << 2),
> +							sizeof(_uh), &_uh);

I don't know if networking has different rules about this, but we usually
suggest using brackets around the if block for any multi line code. Not
just multi commands. If the line needs to be broken due to length, we
suggest brackets.

-- Steve


> +
> +			if (!uh) {
>  				__entry->sport = 0;
>  				__entry->dport = 0;
>  				__entry->ulen = 0;

