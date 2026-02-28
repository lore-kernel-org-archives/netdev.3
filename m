Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF8E54B;
	Sat, 28 Feb 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242113; cv=none; b=CoedJ4LCVqiAtDs+lGvQPR27+uoFxAwMJiQ3ICP4qrQt4S4NhcMkQPKV2urJ8najjerB31CMXujfkZB50Sk1tyl8v+aSK4eDq6ZVrIUnzoF+uM8sSzBudkesMQdbG+uDYfFODhYpDS//zNqkb9uC25CdayswQ4Mhj4XhdkRqUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242113; c=relaxed/simple;
	bh=bSOACrV00WS82KflwidMkbFUOVnHBmgP75j0RF/As4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8CwNLCG14Bu06dO3ZD3jYKP33mgi2OTye8orlbFwGqcl6urZq7rpHadkEUT0gvsQqbDXK8FRdR+Lk1ue0bzxMK+/EemxGel1xYUzOIiQXOmRMLFDQNTzRLjMEmyAnNiwJuqlXEj62+PB9HiiIfIaazDDwesDEk5BFswHXosXac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTEWHB+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTEWHB+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3299C116C6;
	Sat, 28 Feb 2026 01:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772242113;
	bh=bSOACrV00WS82KflwidMkbFUOVnHBmgP75j0RF/As4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mTEWHB+clJKqSb48c1AvM6axLgetEsxAlbrf74Ph26bdPgY3K6/cY72kOwKio7Ibv
	 TDLE0uSxSylG8Wxv76xqAiuDz30FwdasTFvkyMGac+/rZkPor6Y7Mur0FdAu13uWNv
	 9EJhqxax+GkuxKCm+qMPuHe8n+fvCUiVCrFdwgNFY0+8zfb1oCnPF/wYfcXdC97R7B
	 igLfs+FpO79Xrbhy31h3vmluDfILQ1ybDKe3/Egdct2mZJ5qRikHxW9AsttU/CTyhV
	 MTfbPSgjhRVkjpWee8RGETA/wOmcF9wHwTFwbbHG+uVVx2oSOVEg7u3DW6An0gG0PM
	 qd8BfI6v14X5w==
Date: Fri, 27 Feb 2026 17:28:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Message-ID: <20260227172831.5ac5d09c@kernel.org>
In-Reply-To: <PR3P194MB15055DDD60A57C6D9023A277EA73A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
	<20260227035537.2630823-1-kuba@kernel.org>
	<PR3P194MB15055DDD60A57C6D9023A277EA73A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 09:44:54 +0000 Cedric Jehasse wrote:
> >> +     if (dissector->used_keys &
> >> +         ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
> >> +           BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
> >> +           BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
> >> +           BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS))) {
> >> +             NL_SET_ERR_MSG_MOD(extack,
> >> +                                "Unsupported keys used");
> >> +             return -EOPNOTSUPP;
> >> +     }  
> >
> >FLOW_DISSECTOR_KEY_IPV6_ADDRS is included in the allowed keys bitmask,
> >but there is no code below to parse IPv6 addresses into the TCAM key.
> >
> >If a user creates a tc flower rule with IPv6 addresses, the rule passes
> >this validation check but the addresses are never programmed into the
> >TCAM. This would cause the hardware entry to match broader traffic than
> >intended.
> >
> >Looking at the code further down:
> >  
> >> +     if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
> >> +             struct flow_match_ipv4_addrs match;
> >> +
> >> +             flow_rule_match_ipv4_addrs(cls->rule, &match);
> >> +             mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_SRC_OFFSET,
> >> +                                      match.key->src,
> >> +                                      match.mask->src);
> >> +             mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_DST_OFFSET,
> >> +                                      match.key->dst,
> >> +                                      match.mask->dst);
> >> +     } else {
> >> +             NL_SET_ERR_MSG_MOD(extack,
> >> +                                "Unsupported address type");
> >> +             return -EOPNOTSUPP;
> >> +     }  
> >
> >The check at line 68-72 rejects non-IPv4 address types, but the IPv6 key
> >is still in the allowed keys bitmask at line 30. This creates a confusing
> >situation where IPv6 is both 'allowed' and 'unsupported'.
> >
> >Should FLOW_DISSECTOR_KEY_IPV6_ADDRS be removed from the allowed keys
> >until IPv6 parsing is implemented?  
> 
> At first FLOW_DISSECTOR_KEY_IPV6_ADDRS wasn't in the allowed keys bitmask, but
> creating ipv4 filter entries failed with -EOPNOTSUPP.
> Eg. when using the following tc command, the FLOW_DISSECTOR_KEY_IPV6_ADDRS bit
> is set in dissector->used_keys:
> tc filter add dev p1 ingress protocol ip flower skip_sw dst_ip 224.0.1.100 \
>     action trap
>     
> To make ipv4 filter entries work i had to add FLOW_DISSECTOR_KEY_IPV6_ADDRS to
> the allowed keys bitmask and check the addr_type instead.

I see. But that sounds like a bug / silliness in the core that should
be fixed. AFAICT it's due to the fact that the fields are a union and
FL_KEY_SET_IF_MASKED() ends up interpreting either being set as both :/
