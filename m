Received: from va-2-26.ptr.blmpb.com (va-2-26.ptr.blmpb.com [209.127.231.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935E43A7E9
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108953; cv=none; b=bZ+xEf4LwKCEaUZ9jj49dviVT5LbUbDHgNbyqv2s1yZHgsBTDGdwwpdzHCcXtrl2hFtU/5rogdEkIurDTsNIxrXq8u4B+hakwjn7xLRmi8qXx50yUwsgeeaVeLlRC9VIDsoPAaU1XrlvGC+f3v+gGgJQAWKFGJhG/ugQ0+/s350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108953; c=relaxed/simple;
	bh=rIdd17wtFJwx3gqbO/dMeKlTkfLS/Hgoze/PYnQOJro=;
	h=References:From:Content-Type:To:Cc:Message-Id:Mime-Version:
	 Subject:Date:In-Reply-To; b=iq7L8Kkb44L2LZWs4lfcZBZn/75SJJDNazLedir4lJen2GW9iG3ItmiVnlqrXLK+RA3LUsDORsiUs9ZYH9PkfsTnZvp2aDXe6KGDtVMi9ZctyQOnS2i1NOcvGrmaEkijxOEW3hALqqBs5XTvv+9F8QIWSki3p0gkrbXk7zcVud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=WTzgbTYx; arc=none smtp.client-ip=209.127.231.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="WTzgbTYx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1789108931; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rIdd17wtFJwx3gqbO/dMeKlTkfLS/Hgoze/PYnQOJro=;
 b=WTzgbTYxEgJJJM05kfU6eMb65R7k/qRCinS5rWdpB8O8TKIaKbhz/ARZ7Q09vZqu9xKLLu
 7NF8ZszLLXbt3UOUncNevqz4wPAPOlJfksAnSCDeytyjbMNZD3Ot3+fW0I4xNNx/Ka1AAz
 RBivUaLT3XkwKBN/g3aulEJ1hBvrRNgYWTiOYz5AhLT3mYpA7nRfuxtxGi0+XWdGtqO+Hl
 VpQJgEBtGNknZQM32cf3ihIXsalAU3i2dMO4KCuS7CaWpICc1Jq2Ckvac2PmRE17QRKWdY
 Tmijgydu569zMU2AFo6gt2/A1o+553y0uz1ZwqROQbWiG/BeBCfD7Y5bzkdhrQ==
References: 
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
X-Lms-Return-Path: <lba+26aa3a2c1+95f80a+vger.kernel.org+yilinzhang@moonshot.ai>
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
X-Mailer: git-send-email 2.34.1
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Fri, 11 Sep 2026 14:42:08 +0800
Content-Type: text/plain; charset=UTF-8
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Matthieu Baerts" <matttbe@kernel.org>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, 
	"Mat Martineau" <martineau@kernel.org>, <netdev@vger.kernel.org>, 
	<mptcp@lists.linux.dev>, "Kimi Security Team" <bug-report@moonshot.ai>
Message-Id: <20260911064201.46922-1-yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2] tcp: fastopen: check rsk_drop_req() in tcp_fastopen_create_child()
Date: Fri, 11 Sep 2026 14:42:01 +0800
In-Reply-To: <845b1b97-706f-42f8-b08c-90e863edef0a@linux.dev>
Content-Transfer-Encoding: 7bit

Hi Jiayuan, Paolo, Matt,

On 11/09/2026, Jiayuan Chen wrote:
> Should we accept this subflow ?
>
> It's just a SYN with MPJ + valid fastopen cookie, replying SYNACK
> and fallback to 3-way handshake may be easier.
> (I'm not sure whether RFC define it or not.)

This looks good to me. Falling back like this is also standard TFO
behavior (RFC 7413, sec. 4.2.2), so IIUC the RFCs don't object.

On 10/09/2026, Paolo Abeni wrote:
> If so mptcp should reject entirely MPJ + fastopen and no addtional
> code required on the TCP side.

With Jiayuan's SYN-flag check in subflow_syn_recv_sock(), we can do
exactly that: return NULL there, and tcp_conn_request() falls back to
the regular MP_JOIN handshake. No TCP-side changes needed.

> A minor process note: the changelog should come after the tag area
> and a '---' separator.

Noted, thanks for the reminder. I'll draft a v3 shortly along these
lines.

Thanks,
Yilin
