Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F966544D55
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181879; cv=none; b=M7W7wt0Ise7BQfoFTCarZqiOGDmGIo2vpN2ZlicsKn14NWnHI7wAhEJAJt/ODXgx7rBCoBV3ACtT6fiVTCosCEjmx8w91jXzpJc5liq11rbdDRn4YuPXLj9Hc9ZddlAC4w8OdUELAdXDrgMUYrqpWdyDoLkvM9LR7PYH5lrD5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181879; c=relaxed/simple;
	bh=B9EHt92l4cCgBJ3GiYXSWlzX+97wDc8O32okFieiohg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MCBhsCgaapuJba1ufFWSGvp9WqOZBTtdPxJALaVkmIRdJRuZAxsDlHLG5mz9ln7+fGYxZQo86nuxKmXHW0NsXhLb+LyL2fbp2Fra5tktjBlmZ8wOL+fRdcX3YsWWIR+8X0pok8/vvDazDssG3exUV4KhhRAejuAtw8g5Wrgp6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/6yyyto; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/6yyyto"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43db0c16so17372617b3.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181868; x=1790786668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/OQhA8DS7XwrIGnSaeM2sMN8OtyGqVT7s29pdTvBStQ=;
        b=W/6yyytoCjPgjpJCHZLzhTswf2+ed9prtlviOTIaP0gPVCCyMZqLQyADqkLfgpMnrY
         Qi1uhTu0XNKErYCquFVpo2LLZneFkTEgVTJ5rGvm6Lh/foCzV4i3sag0ifmAlo1sKozE
         QosRIwY4NZnPNTEUMXKtzWb0kGsaydSkcd7CPC+u43caseWl0d9y3uF7XXFxDexHQRnX
         jBUMkE54+9uq5kx0/otscvr2WKJsjNLIK6FYaYWqRfKUJrucB0gcX+8dVspMoIN09NLK
         +SZ95++1X/ef2JoYAClkpTR16J55L+2e/JmFIGZq7TznrSvfm8Usjh+NJxK8Xo20apYM
         pKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181868; x=1790786668;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/OQhA8DS7XwrIGnSaeM2sMN8OtyGqVT7s29pdTvBStQ=;
        b=ABL4jYG/m4830labhO38DMw76OIj1eywdffA5bQsoKBLqYTS6yBSS+NGS+Ta3htp+/
         XqUEVQgLuTgMIRWAbEo5fPwhuh4p5Pow/y0VDVzU9CZoYQmQTRAHqD8NiZuBi6xKguim
         NQ0I0pVUBod8te67px0hoS8JOlI8SrCmF59FjLi7txXP+UWWadgxQQAZicfqwILhb9k5
         btNpv67Bqd8TyHJPNyfvz2p4Xp2R4DLKcVbdLjTrFLm9iioKFCveqTJZHTClnEM92OO2
         WPv2f63bcFEAqSoTMwHDNnx1g1mva3pmuJ0EkL2Jtund2moFJhDYDwR+ZoQnewP9TeN1
         uzgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzpqA+BJVgACPaDvpeM+oK04N+jQ5pn5x9LApFPhSCVkxnUbW982Il8qQaAWH9QZ6U/rT2znk=@vger.kernel.org
X-Gm-Message-State: AFuF++mYkObza2/I7IAwgCuDHUav1IqmlWENYdHpS6rAogobFkkkcmWE
	+K3lNblIL2Kb+ATl7eoZw2mruEGtrk6ndi7/oTssHNZuXky+kBStriCK
X-Gm-Gg: AYBFou1gD6gNtb+hAXoSvV3qY1A47Jh8huWRpqp/TjmWfEzmJU7GfcSOEQp9DuMxeGM
	M+sykexrTHdpMAQb1jdvfyeYrQpTpVCg7GWghGx0TNDk8DjYxJ8EXqZJGv0fkQGMTVff+dAmtNB
	oSSJv8KRMktlnyuYKmNtWl+4br6Y/5+ZyRofyWuiWmWiRZgwkbs4AifQC3gGpDXat+mY5ARMSDR
	j99djLN6QWtlf7PFmVK+WBkvBy9wE40CtjhgIz8S7/B7DoUjbZoztoGqIJ9sZ7UR1E/EVRH2Th1
	qmTG2/QCponHffLbxkf5uhP6YpxIcqZh/JzTwFWFhiK86vqNgLHQiHXr2CKN9w4J5vWF6eVnQ97
	6NIASuFyIiSmqPEQ0OkY6+E2rz/Cdr7VqgXMExfhD+AeLCXYS+gwU55clnuXd63NwXDet7kINq6
	9JyyjvYeuXAe+l+Vfb05q/6IUrEAvJMYHRPdKO3ndb9D+5SS2OhqSGNikGbxo4i7AZt7h8tApT+
	ldaxlRmpoQKeIZmw6Lv44Mtcpt24wrXJutqyG40oZLlFG3RRiT3ejTVi/zVumo=
X-Received: by 2002:a05:690c:dd6:b0:81e:9b09:7210 with SMTP id 00721157ae682-8a4584510a1mr21559537b3.16.1790181868432;
        Wed, 23 Sep 2026 09:44:28 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4662b8259sm12757897b3.28.2026.09.23.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:44:27 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:44:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Wang Zhan <wang.zhan@smartx.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jason Wang <jasowangio@gmail.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 dev@openvswitch.org
Message-ID: <willemdebruijn.kernel.203ea450da2a2@gmail.com>
In-Reply-To: <20260923103825.4000903-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-3-wang.zhan@smartx.com>
 <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com>
 <20260920131231.3610688-1-wang.zhan@smartx.com>
 <willemdebruijn.kernel.eb2b72530041@gmail.com>
 <20260923103825.4000903-1-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP
 segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> On Mon, 21 Sep 2026 17:07:09 -0400 Willem de Bruijn wrote:
> > Somewhat tangential, but an entirely different practical approach
> > could be to disable BIG-TCP when such a patch from BIG-TCP capable to
> > non-capable device is encountered.
> 
> That means a single device in the topology which does not support BIG TCP
> forces every other device to turn BIG TCP off, to avoid the degradation.
> So with mixed devices and a dynamic topology, BIG TCP cannot be enabled at all.

True. A question is how likely such a scenario with mixed devices is.
I.e., is it worth the code complexity.
