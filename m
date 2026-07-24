Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E592EB10;
	Fri, 24 Jul 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898725; cv=none; b=ZR8nkMuIcnwcIJPlAp8O9hbT/Dp9DGW7yXiJwwv3WpoiZtE0oFIJIeA5artuZy/leiCa2ezAWS+p0WZaG2kjAuowYhnwqtaa0Mj6mBO7WIqUP6K/EmRnoFCc/J7z0w4+kbgHMzjCAghcV39968HbIETx/NjORco6KyOBmKO5B0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898725; c=relaxed/simple;
	bh=5TCrXdzINLrmaRzaRclbv/naPHnlc5bzoO9pd+8S1OU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uRWo5rPJJfzwY/UzRyBOaaf5pjhNPC09f5RcKBgl6spwc20hebQTWRt9c7X9eTQKsvhd3jHdlHbkLEOaqp0EBqoWouwg8s4ydV0ZwlPhVao9J12syUqFrLV89oo1Ry1DXoPXoLJmI7w9ix8zyJff+gbzooUHl3M4/M2pi2Q2Brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=95Oby/9i; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=KThpq6fo; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="95Oby/9i";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="KThpq6fo"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66ODB5uB026371;
	Fri, 24 Jul 2026 15:11:10 +0200
Received: from lubuntu-18.04 (host-82-61-152-174.retail.telecomitalia.it [82.61.152.174])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 54FC5122966;
	Fri, 24 Jul 2026 15:11:01 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1784898661; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/l880RV9gSkJ6HItG72E2XbASSeHX4In9eGtV7b9xI=;
	b=95Oby/9idN7Q8e7jVHIirr6RxpP1ek5IeQmy1lpjKKiSQ6TKVVp1CMa0GWDxlNrxgqaT0a
	vDIxilJtgNRdsxCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1784898661; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/l880RV9gSkJ6HItG72E2XbASSeHX4In9eGtV7b9xI=;
	b=KThpq6fo7GwJ3+6qHSZSWPanR4Nmh2j+UIqcJacU+2wpSWmBeOhejSZhiic3405ienxVUB
	7e9oJ5UaLPG4tqkxYKBEoCplm9SoC7O6xj6Kh2M4B3gN78sJOYnJbxCBRVp6sMgKjlhu0F
	ikcNkFvo7hl9UFDm8EzeWP11u8xRcialSVIjyeN6onLDcl1V1YQFjPnq2oTs/Z12TowHkJ
	b/UdMB34JhJz9H9NCknoocSzWckV+GgV80Fvs6JEOpU/ntpx9Ba7/g5bUYj51EuibhicK4
	/jkKX4/JOfVOhWNyCrt0NOt0Ed7eMtpFys1FpfGq5uHVpHr0SFwRwppG1b6UQg==
Date: Fri, 24 Jul 2026 15:11:00 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Xiang Mei (Microsoft)" <xmei5@asu.edu>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>,
        Ryoga Saito <contact@proelbtn.com>,
        AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
        kys@microsoft.com, stefano.salsano@uniroma2.it,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix NULL deref in
 input_action_end_dx{4,6}_finish() after nf hook
Message-Id: <20260724151100.16b60b15db7c6353b4fedf99@uniroma2.it>
In-Reply-To: <20260723100949.4443811e@kernel.org>
References: <20260720204430.1886091-1-xmei5@asu.edu>
	<20260723100949.4443811e@kernel.org>
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

On Thu, 23 Jul 2026 10:09:49 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 20 Jul 2026 20:44:29 +0000 Xiang Mei (Microsoft) wrote:
> > When nf_hooks_lwtunnel is enabled, the End.DX4/End.DX6 actions dispatch
> > the decapsulated inner packet through the NF_INET_PRE_ROUTING hook chain
> > with input_action_end_dx{4,6}_finish() as the okfn. Both functions read
> > the lwtunnel state via orig_dst = skb_dst(skb) and dereference
> > orig_dst->lwtstate.
> 
> Per Sashiko's feedback - we need to validate not only that the dst 
> is there but also that it is of the expected type, no?
> -- 
> pw-bot: cr

Right, and seg6_input_core/seg6_output_core in seg6_iptunnel.c (added by
7a3f5b0de364) read skb_dst()->lwtstate after a NF_HOOK too, and this patch does
not touch them. A hook can leave a valid dst whose lwtstate is NULL there
(reproducible with SNAT and an XFRM policy), so they need fixing as well.

seg6/seg6local behaviors carry their processing state in the route's
lwtunnel_state. That state should be preserved across the hook, and after the
hook skb_dst() may not carry it, or may point to a different instance of the
same type.

Thanks,
Andrea
