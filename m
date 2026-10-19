Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425343;
	b=tIUsy6oFBcrj3vYEbYIvcUpWRigbxB2WmpafRAonEoMwXyQ7LR8g73sKK6RmgVbnGQ6P
	 CBMCZHNTf/1Vn+22+G2j+1Q3X5cExl3fmIQPxGN66q/40WQFI/gIXjsEAQirlC6yL0koJ
	 DisFk8+DVPMB2oQNYuNDKXrIg116xUTQ0ljEbof5RprnRQoPJG4MPE71retBMUMTjL4Ur
	 9CF39u/WpW+Df6qGFX4e3rjWC8xKKsrk3NsQTlgMVilpmTNrwlHSn5yd16QPiduaq3M5V
	 ggZaaesC5rS8PEHe/RrYzL5wPvaKub0KxdCSMR/nWzZ2myBU89HT5qC/Jp9nQKiGqKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=BA9zoqXOo/u1x2NpKUaBSGpkeU42OJi0fUHglu0fhGGFcqv5igRFimf01C7plC6/EkM7
	 971SueuE0+hI+pBPQYI8ZwPkA3p+w1IxUVxbGN19dQe7rloGDNOjwmajlqEY1HIUab0K/
	 nF6OJjlMvKDY/KyxqdjWtmUpDT+xaBreZ2FMeyDRzY3MbMxYJS6fbRp2Cxm2IhZDJOscB
	 RvAe3tPAs4pgttFrAi3ItdnbUPVaP9Ph3cB4vXhCblLDWcws6lHoHQ/7ygNzbLptbn0Z5
	 EIIL7I4wPPLlrax6gwp5GSu+6rXOppZ9px7JlhL7Ynm7EHjqjgSUJaKV3F8NRMC7jHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT3bTU1L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A078606C158;
	Mon, 19 Oct 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT3bTU1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0288D1F000C4;
	Mon, 19 Oct 2026 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792425342;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PT3bTU1LF3kvkeZfpU/17oVGDFJU+mvPHPE8xSHnWvvlJMv8PRmawiPhYpEv2xah2
	 zzmhh+rkAVFlyZ4D6Q/0rJeph7myDtuaUDA6PPUvKmZPolmARRluIgbJaEN7qNFe+2
	 J0TT50RslHVfmGsWJ3FJzYy7HSUAnWvDrucbdERHYOUYNzinMWOiqC9DRw9zgmvlxI
	 LRblNkTdnP9qI037SRTKOhR/K2/OJcQb0GP4yfREQAjhzmS6+E+wBR37OF2uACdZoB
	 wiUiV3UlX5DyQ5AoFi1DQ0hz2snyXgPV/GaDUWk6zsZwxUET/HBhUrxx2AdhflnOAN
	 C99T4hmaWBPfg==
From: netdev-bot+sinfo@kernel.org
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/3] xfrm: fix vti tunnel device use-after-free
 across async crypto resumption
Date: Mon, 19 Oct 2026 15:55:41 +0000
Message-ID: <179242534145.3290.3021737362277964895@kernel.org>
In-Reply-To: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
References: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
