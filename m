Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379FA431E68
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075008; cv=none; b=LUG8hThUgrvkO8oZEvD0SBZ3bpmPZhovOBNPt5lb++ovIArjLSAedKy1VlUsNwE7vjyLS3E05FmZwuOO6tLumkO+8DS2LK8Lc6E0+srUofmIsjA4IIOQDZJWLcgbcU2GNdQ07g7w0bfBnCCtEQE+EO3jY0U5Qeq7Dg/JxWKWPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075008; c=relaxed/simple;
	bh=v3LtcChmlu6SB+VZ0fqku7Px69SBGP87+uBsZMta9Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC/zdksRxC82mlvSz13WPqxI09zAaYfmv5icfWR8c60KCOpMYY3HEWtBGMCvNxmIPi9XBjzohPThcGjK3ew3QIm/t2+MOKnrvFH+fvcPRL7A3uBdGygvZ4sDzM2rRUJfoT02p+tQ/CMkSHO1qd9q7kSRV0AWuEOdTLKhatipx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEhUI8XO; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEhUI8XO"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0c89e34so184667a34.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789075003; x=1789679803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bIbUN3PnOKMYcTb9Yn8F89rjLLXVVLAIKHLxZoe9RXQ=;
        b=TEhUI8XOglnlQrMTApDbbewyiIfj2EaGZd5jFBqp23MAuVfVpEiTgCzJGosPLnh4k9
         qxnt5b/VwKR27ZxYgmSdfj+E9+cEVhKQp9JWax6Jc4O9hgXZJ2mp7IItvCY9yWTQo1TI
         2EnVcHkS9DQD5TboWBAVHlwrfrFOpAixI2icZYAjF7xJ/6XPfsqB51ORSLWB6jZC6OMI
         CYljAngmS3GAlfYpMYDZqDvOQ5qNDFdFW7ctciThlKcMdLpIaf3iZbrgqRJ1jfhhzprt
         jlpT+KpAF2Uq5hq1+Nt9R516V98Kb20CtGCAqEkVjSS/891L5WdBPzr7meAiD1kwTZ/G
         143Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789075003; x=1789679803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIbUN3PnOKMYcTb9Yn8F89rjLLXVVLAIKHLxZoe9RXQ=;
        b=BHuk2i8xAhKVRVbZr+CkzJnqmf25mK92L/IamLtpjIgr//YxRzPPXCEbOQ1qR2sMrM
         3AiF4vUY6wBKHb0XD9/xhuE38K2vuO7DuSWZK1qP7q1cZnYyhFoLVA3B0hyu0UCVaDO0
         ShTU/JofJk7188NXVmFz7hrzcPsqMG0vCrKzZ5khXNPKEyq+YOvHrYA92ZcmyV/3SA7f
         49tqrszEBrRGl4MXOn8uy2UG46ePDLJfTAxkCj2oRraDoerAREEquZqyz+pVtcqrI8X3
         FFyfaVEorSn6Vs7ct80vsuHTKDFthSVna033KsRP0ewan4S0EdzyjLNwIM/CyVuANKWv
         lUGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmzP4uUYviVyEA8fB8Cu2PefNk5Io8flPucJbFj6Vz/uQZ8WHEWq9UCBYV3zTHK4S68C0qaJw=@vger.kernel.org
X-Gm-Message-State: AFuF++lSt74RzoE56Bvv+izUJIlDFx7wk/OsKniFGgJNRBM87IDnuFhd
	DSNL2nwm7QmQUx9AmplDFlf4uCT4RQwjdgBPYUCuxyNYnP3Lqjm9tHQp
X-Gm-Gg: AYBFou3DZqztIqK1v1S5noPpEV0xu9guJXZ3MUpArUPf0diPODvtWwF/jKKnNSaRRYX
	XRPCDsWfI3ZuTft4P0wy58B9GfxNqpGjErmNpjAYKTQhHkLl6Sr4hOixA8MBP4NBr9WZAuGxzkj
	P/dd0XE8mwyCaUwiqUvUte7Z/YPOUF2q3AAHBbE/AqdnE1euk5i+68PpFwxoT9acM9imq6zUP7c
	TkWDSOWjBl3BUEaiB2Gf+HtqXoDQ+iKaA4KYsBeEcZuzHe8eZa3zu+CAAsCk37hEkwWPVWUTrSx
	8EXx/33cPwm2M+GoCoCurQIxbMm9Beo2F85OkowhsTx+gykmdPKD0mNAGilDNhUuPP/NqOzYpwA
	tzeDyv5SeMGj33kIj1OLHRTK0RT11nAYyJkXlPFDed7gvM258vw0vryoyNC4KDjZcYB2k0cikjg
	pMc9wy+B9/+4I4q5QwymqIuosem05b5jP6pM8uLlvKl+T+H9q37x+3saMuzfZqo/CmusT9RXwNf
	PlrI8D1KlDjM9iMIh4J
X-Received: by 2002:a05:6830:82a5:b0:7fa:5c49:5239 with SMTP id 46e09a7af769-804013517bcmr526389a34.18.1789075003468;
        Thu, 10 Sep 2026 14:16:43 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5adf677sm659316a34.4.2026.09.10.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:16:42 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:16:39 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	matttbe@kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: Fix out-of-tree build for ynltool
Message-ID: <aqMeN8/UPhvJWvR5@devvm29614.prn0.facebook.com>
References: <20260909071155.1234922-1-maxime.chevallier@bootlin.com>
 <aqLkhcMb8uSKhQZl@devvm29614.prn0.facebook.com>
 <17c701f4-e0d1-406e-ab4b-7d56d3eb5a09@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c701f4-e0d1-406e-ab4b-7d56d3eb5a09@bootlin.com>

On Thu, Sep 10, 2026 at 11:12:24PM +0200, Maxime Chevallier wrote:
> Hi Bobby,
> 
> On 9/10/26 19:10, Bobby Eshleman wrote:
> > On Wed, Sep 09, 2026 at 09:11:54AM +0200, Maxime Chevallier (Netdev Foundation) wrote:
> >> After the blamed commit, running a out-of-tree build for ynltool fails :
> >>
> >>   # make -C tools/net/ynl/ynltool O=/tmp/o1
> >>   make: Entering directory 'tools/net/ynl/ynltool'
> >>   make: *** No rule to make target '/tmp/o1/json_writer.o', needed by '/tmp/o1/ynltool'.  Stop.
> >>
> >> ynltool's Makefile correctly accounts for $(OUTPUT) to get the list of
> >> object files to generate :
> >>
> >> OBJS := $(patsubst %.c,$(OUTPUT)%.o,$(SRCS))
> >>
> >> but it never actually set $(OUTPUT) before the blamed commit, meaning
> >> that out-of-tree buils of ynltool were always actually in-tree.
> >>
> >> Now, the O= parameter is correctly accounted for, and the %o: %c rule fails.
> >>
> >> Let's update the %o: %c rule to also use $(OUTPUT).
> >>
> >> Reported-by: Bobby Eshleman <bobbyeshleman@gmail.com>
> >> Closes: https://lore.kernel.org/all/aqCyWQxqKDuQnZYR@devvm29614.prn0.facebook.com/
> >> Fixes: 917f713b4ec4 ("tools: ynl: Allow cross-compiling ynl and associated tools")
> >> Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
> 
> [...]
> 
> > Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Thanks :)
> 
> Nicolai noted that there's another improvement to be made, as we don't
> account for modifications made to .h files. The diff would be :
> 
> -include $(wildcard *.d)
> +include $(wildcard $(OUTPUT)*.d)
> 
> See [1].
> 
> May I keep your review tag if I add the above diff in v2 ?
> 
> Thanks,
> 
> Maxime

Yes, np, feel free to carry it forward!

Best,
Bobby
