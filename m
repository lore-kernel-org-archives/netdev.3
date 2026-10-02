Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A54F6462
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959930; cv=none; b=YXkraA+M7SsnwGtX9seehWAipkFEGjJ+V/q82IVEpDeoc0sVSL/h2KUsao1YLe/KtHc5xiNc84fgTF7e63yZ/a9wCccrNyPzBvev8gAPRCcVv2qjrFoRTZkNiwTgeI5aUgETsRsk0+f+os9ktzAIpPnN0gM3syOuAwKcRNTs8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959930; c=relaxed/simple;
	bh=qOhVJJ/MYa9waDmR/jLT+QnduT3IOPsL7RTql1pPIe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3pyn7LKSU3mY/cVRQAJlhxvwVr1HhvJckTLMlKML2pzk8kEvnxds69jOB/aoRSpMPBa13eh+pG2vPRwgFv6EANmG6k/7K7UCX8EpA7DAvm/syB1wT8oeDRt+qe3ziJlnRrukwgCAdhE/SNWTcvIsXs0hi73rZMYm51NdegFuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=XVLmnZSX; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="XVLmnZSX"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so7596445c88.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790959926; x=1791564726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/dV9xnkG18EPuHyoSKvuCKSD4dj0ouxy7k7+KE4Y5Q=;
        b=XVLmnZSXkywsi04IRb1E08UhiYxtclu2l14CXzYNhppyxNRSI5f5rGfxYTy766IqhG
         GVsCrzmXJ0LMn5d6Ij+x56XUFDsZU0NKTVfNheEg1RaO/8/LG7EdxLLs9pZwoJLCT8nu
         f0cfueKBeeXxR5K5gRrEFHczFVlmqivOF4n7tUTJi/rZ8QoGID7u4qR9xiI7WNRYH6U0
         KgA2gCxXBW9N8eWBYeYQeHEITta60+6qI2hbaUMsZZXRqZRO2+m1pSwoSroffAWN6jGp
         QXdJFF2IJ6G6IXYbZ14SzLhw7HWYfcdaicGbyoEtxbfuXXHfBAJsGYZlhm7KdbtsJ9Hz
         siFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959926; x=1791564726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/dV9xnkG18EPuHyoSKvuCKSD4dj0ouxy7k7+KE4Y5Q=;
        b=sPy1vCPHxGqMWExuHUgvdEil9psxQuIhCL0C+8w0MKRKRc5ZnF9ozMZ4lWfwpCOIu+
         D8LqrSSkxzqh+kBIcZx/huw0pigdfU01I8BNVFiinK/qXbFs4YMI9l7yx4xbBOZj6pNP
         LtJ4upKLBacVOHTXMh2dpHmJpQbdKHDcVk0MquTTIsvukaTgh/D/yKEiDoINczH8RvGu
         lEBij9MMeUcx7kwMUwmyDUB2ZuAnQn6gD/1nJP2MrD7imOHCmXkriyS80c+O+pOhjQMq
         PknvoVzO3BdMI4yKHXzZgiC+V5JnmZwh9MpASIiZakcEhAvfHrYftqWeZGbtUiMNMvub
         oi6g==
X-Gm-Message-State: AFuF++ke4lRZzWdUu22rbGj3t1ly1kEzwiep3+pdAM9TlZtgJNkxG65I
	rnb2fH6rEMl56/l3HUyPZqKZ5iuDt4VBeE/ALzgnYrK3XDR7r45te/O3HILfrUZ9ppcdYP8MuTc
	ECBaU4sf2D2hMTDm6qunCeynRhxSz9CZ4AN9rqEOmFxj+vX1m6Nz+YY0q7CGX09XBuDhIjx+q
X-Gm-Gg: AYBFou3R3aUAMSTYLHoa5zLKG0y6JAmSJuu4uSRxHipIX1+PNL+iFpqBfXKL+4Uunn8
	tWMRS/R8QpvOogingAOozwvAeMGCJM0DjL3p5bgNddn8/Q0Hmycpdjt/8Lfab2V3AkkIOo2T/ln
	fy9GYvYzmn3WHpytJUQAfxygT5XtsSlZIGlGNwZi3Yvq6l+GU7uTwMTF8S2SMG2Ied6TY1rHSZL
	NHMvbVe2t1kr5KJk5cohd4K3FeWf46BSejXQ1IfpMrOaW6oHxq6gxI7xzG1t+Vkj1x3BbaMn7AP
	qfxcxhhsXosi2Q7Jou9/F2xpLBbl5gNH7312Uw9IxG4ZmdubGkIS98oYPmjscmMtCGu8JbAftcW
	CDQDDPDph5kKLDvx8LUskEtqQTISEwFEyWr3Y3OATApyB0EDwQtHtfmzZcKBEADCuYfIO/9MaVr
	iP03mbmPliJzseJhVibiYwIUCCvi+wHCUKRjhWrKg9wqrfXKA0f3Q1xfdgiz1dbVMOKekGzhxGU
	dSab1cPKTDYKCoTZSqWlg==
X-Received: by 2002:a05:7301:4887:b0:344:7aad:8eb5 with SMTP id 5a478bee46e88-34f150ed00fmr3450622eec.23.1790959925691;
        Fri, 02 Oct 2026 09:52:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f652absm9585250eec.12.2026.10.02.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:52:05 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v4 3/5] net: gso: support re-segmentation of TCP GSO skbs
Date: Sat,  3 Oct 2026 00:51:44 +0800
Message-ID: <20261002165144.2240646-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.30c9628e9a7f6@gmail.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com> <20260930111526.2183107-4-wang.zhan@smartx.com> <willemdebruijn.kernel.30c9628e9a7f6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 15:52:01 -0400 Willem de Bruijn wrote:
> If respinning, consider asking the LLM to rewrite commit messages to be
> more concise.

Sure, will do in v5.

> Not new with this series, nor high priority, so only if respinning:
>
> Consider adding
>
> @@ -5121,7 +5121,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>                 }
>
>                 if (tail->len - doffset <= gso_size)
> -                       skb_shinfo(tail)->gso_size = 0;
> +                       skb_gso_reset(tail);
>                 else if (tail != segs)
>
> Because packets looped into the Rx path will sometimes have their
> gso_segs used without first checking gso_size /  skb_is_gso. For instance
> in ip_rcv_core __IP_ADD_STATS.

Agreed.  Several places count with gso_segs without checking gso_size
(ip_rcv_core, tp->rcv_ooopack), and with this series the re-segmented output
reaches them in-tree.  I will add it as a new patch in the series.

> Additionally for patch 5/5, consider one testcase that resegments, but for
> which the last skb is not a GSO skb.

Sure, will add in v5.
