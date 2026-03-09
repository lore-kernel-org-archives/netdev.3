Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B4332612
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090019; cv=none; b=JDMH038/huLt+/WW1Rdnt6l8uhaKbta5u/vnNPXTvU1XrXbg6PHjhW3US79vUjjhMOoqVKUzkcebRvWw/R7OMdHB+jO0o1aX/Qk3EIKF6gOM/j5ny0nG54es9sL3CWTVuZGAoypCFV6B3NhSGpkU21wet21sgSRoRydEjAHwJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090019; c=relaxed/simple;
	bh=63H2dzec+PoW+VkpXBk76WBfGrj9ylCJJPLzxyfQ4aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btce45aq0z6Pj79uszS2Mb+3DCdCqAf2I4igjVNq6UgX+H0OUH1f0iH9bs2zo3fqLKCK3aln9Sa9f57Oe8f4CF7nc7LFJJEHnK9Cr/LvHfquenZpj2uAjhYYKzCpU9eGYBUOyrELxDYs7M/OZ8VJi9NCUxrDZ1CtpawrUch5TYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=P/zAisZ0; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="P/zAisZ0"
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id 8ST4V7FynBrR5VZd; Mon, 09 Mar 2026 17:00:09 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=63H2dzec+PoW+VkpXBk76WBfGrj9ylCJJPLzxyfQ4aE=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Content-Language:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID; b=P/zAisZ0GXVhJu/k9aeD
	PDaaxj3slIMpq+0BbOaVlEJIi3ZjqPFvdrnVBfTDqizBzZROoMrADrxjjJARK7e9GWgFl90RcJJtd
	1RSc4aZipiV7RUFSMHZAblWB85sadPRiL0oZVYw2XPJQ3f46CpEKeCGql2XJgj80ZLzmOKV1so=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14451426; Mon, 09 Mar 2026 17:00:09 -0400
Message-ID: <a4686348-ad60-481b-8898-9c68e9c27a50@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Mon, 9 Mar 2026 17:00:09 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Long delay in freeing skbs
To: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
X-ASG-Orig-Subj: Long delay in freeing skbs
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-3-edumazet@google.com>
Content-Language: en-US
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <20251106202935.1776179-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1773090009
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 0
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1451
X-ASG-Debug-ID: 1773090009-1cf43940a6bf760001-BZBGGp

I have some out-of-tree code that was broken by commit e20dfbad8aab
("net: fix napi_consume_skb() with alien skbs") in kernel 6.19.  I 
retested with 7.0-rc3 with the same results.  I'm not sure if the change
in behavior that I am seeing is expected or if it is a bug, so I thought
I would ask.  Omitting irrelevant details, my kernel code does the
following:

1) allocate a buffer
2) perform some network I/O using the buffer (cmd over iscsi_tcp)
3) wait for the I/O to complete
4) wait for the buffer page refcounts to drop back to their values for
idle I/O
5) reuse the buffer for more I/O

Step 4 is necessary in this case due to some of those irrelevant details
that I omitted, and that is where it trips up.  Commit e20dfbad8aab
seems to keep the page refcounts elevated long after the I/O has
completed (hours or longer), presumably because the deferred skb free
isn't happening for a long time.  So:

1) Is this long delay expected, or is this a bug?

2) If the delay is expected, is there a way for me to force the network
system to process the deferred skb frees on request?  e.g. write to a
file in /sys, or call a kernel function to flush the deferred frees?

Worst case is that I can redesign my code to kfree() the buffer if it is
busy and allocate a new one, and let the old buffer be freed
asynchronously when the skb is freed at some indeterminate time in the
future.

Thanks,
Tony Battersby

