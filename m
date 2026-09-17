Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CF04E73B8;
	Thu, 17 Sep 2026 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663427; cv=none; b=UD2qUHe16UdckglSID4+AlLopaMAc1ueUR58JUr0nJSNFzoigRnjMxmLUpSvaTFbYoIe7PYPJ++gmzzukfzgx5o8DSMnyB3IGxlFAHOtm9a4U6s6YcsYLPeoP5D8QylKqCr8c+u+56OGhsNSphXmndqHyjvwjBFtA/1W4H+xEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663427; c=relaxed/simple;
	bh=pagyd+150oEb46VwCvpsCbbjdGkDl14UOcEjHYucwUY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SdkjtlzflOs/4hb/YBB8oOuLIhxcEYn7DsgUDHHFBjPkP/9ZxkXs8U4msEPhH4fBvVGBXIwN/JVOGQM2eeJbKF1tlBYCGUQfShYMYOjiEK28//wDc2tRySTtywLHoF4QUO/q4z//ss9BOf6bQYp9Qujp6pK1K6mDqAlDwIUQACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=NUSsVjPB; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=peJ4OuCq; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="NUSsVjPB";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="peJ4OuCq"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 68HGSVaZ006068;
	Thu, 17 Sep 2026 18:28:36 +0200
Received: from lubuntu-18.04 (unknown [139.28.148.6])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E0E54122986;
	Thu, 17 Sep 2026 18:28:27 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1789662508; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23NEyPoqoyAs1RcddRaTNC24DxML+GBDLsNye3dpMRk=;
	b=NUSsVjPBjGTVw5wsoJsFG/5SC8nqyJOje+tDHMdnH3xAahG88nht+QOhLye+hqsR0OjmoQ
	sR2NyxrPvGES7qBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1789662508; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23NEyPoqoyAs1RcddRaTNC24DxML+GBDLsNye3dpMRk=;
	b=peJ4OuCq0EbNdoMRH4H0gla7UaIc2NXolSdR6hxKJ43sUYUXHs2SK2Qp5i+Q/YaZQLs9Vx
	jrs3tTFyL4VMkO2WnclzkL4w6R/wdFh2zuJCyA1C4TqMLs7QNTDgCjdteu5NvWKBFPwW4k
	+KAcVqgDr5puYSoqKtqi0p+7DwYR5abiZIJXMVTeH3yEHuXDC66lnQMjKexuIOJgrAhSpN
	pmZSberQSud9PapGSVxjd0lqSU4z+aF8ideI0csciiofBYLHGS33JQozDu3LKi9/p45NGm
	RCMB8fI8UP2SyHFSM5Xk72ByaenNM+50p9wY+eSXjU8NLSt0neAsYebFVe9jeA==
Date: Thu, 17 Sep 2026 18:28:26 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
        "David S. Miller"
 <davem@davemlft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: keep room for the mac header when growing the
 headroom
Message-Id: <20260917182826.452d987261004173916e9722@uniroma2.it>
In-Reply-To: <fd0ffc06-f1c5-42d6-ae16-b592208c6d69@gmail.com>
References: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com>
	<fd0ffc06-f1c5-42d6-ae16-b592208c6d69@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 17 Sep 2026 12:12:11 +0200
Justin Iurman <justin.iurman@gmail.com> wrote:

> On 9/16/26 23:38, Yuya Kusakabe wrote:
>> [snip]
> 
> Overall, LGTM, thanks. However, I think we'd need a v2 with the followings:
> 
> - use max_t(unsigned int, skb->mac_len, dst_dev_overhead(cache_dst, 
> skb)) instead of max()
> - apply the same changes to ioam6_iptunnel and rpl_iptunnel (all in one 
> patch is fine)
> 
> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

Hi Justin,

Agreed, rpl and ioam6 inline do trigger. Single VLAN device per side,
reorder_hdr off on the receiving one, plain ping:

  BUG: KASAN: slab-out-of-bounds in rpl_do_srh_inline.isra.0+0x3d3/0x770
  Write of size 18 at addr ffff88810deeba7e by task ping/447

  CPU: 0 UID: 0 PID: 447 Comm: ping Not tainted 7.3.0-rc1 #364
  Call Trace:
   <IRQ>
   __asan_memmove+0x38/0x60
   rpl_do_srh_inline.isra.0+0x3d3/0x770
   rpl_input+0xd3/0x5e0
   lwtunnel_input+0x18d/0x420
   ipv6_rcv+0x452/0x460

  BUG: KASAN: slab-use-after-free in ioam6_do_inline+0x2d8/0x5e0
  Write of size 18 at addr ffff88811480fa7e by task ping/432

  CPU: 0 UID: 0 PID: 432 Comm: ping Not tainted 7.3.0-rc1 #364
  Call Trace:
   <IRQ>
   __asan_memmove+0x38/0x60
   ioam6_do_inline+0x2d8/0x5e0
   ioam6_output+0x335/0x970
   lwtunnel_output+0x1b0/0x440
   ip6_forward+0x16a7/0x16f0
   ipv6_rcv+0x452/0x460

ioam6_do_encap triggers too, with three VLAN tags via tc push:

  BUG: KASAN: use-after-free in ioam6_do_encap+0x202/0x5c0
  Write of size 26 at addr ffff88810de227fe by task ping/453

  CPU: 0 UID: 0 PID: 453 Comm: ping Not tainted 7.3.0-rc1 #364
  Call Trace:
   <IRQ>
   __asan_memmove+0x38/0x60
   ioam6_do_encap+0x202/0x5c0
   ioam6_output+0x3cc/0x970
   lwtunnel_output+0x1b0/0x440
   ip6_forward+0x16a7/0x16f0
   ipv6_rcv+0x452/0x460

I would fix dst_dev_overhead() itself rather than patching every
caller individually, that covers all callers at once and protects
any future user of the helper. dst_dev_overhead() already returns
skb->mac_len when dst is NULL, the fix would make the other branch
consistent:

--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -455,7 +455,8 @@ static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
 					    struct sk_buff *skb)
 {
 	if (likely(dst))
-		return LL_RESERVED_SPACE(dst->dev);
+		return max_t(unsigned int, skb->mac_len,
+			     LL_RESERVED_SPACE(dst->dev));

 	return skb->mac_len;
 }

What do you think?

Thanks,
Andrea
