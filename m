Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE30392C2A;
	Tue,  4 Aug 2026 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879241; cv=none; b=W9NDJLZVLRBKmevRlIUifB2gD3YVfo31DRNSMW9nSwMiHPbyPQH9VP7v+ZGbyUGELijrvquqqZSMi4jYTU6RDGfHDtSVHBimu22ZFujajspQZSx0rCjmBVHzhsjEwIZKG6FHSHdlFuO+vn9MZ3aOeOVx/djohwKxII74zGKoVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879241; c=relaxed/simple;
	bh=zWSsvq9Zpr3aixS9DWQUQ2fTiJM+LoYd4JEylO4Gpx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy1BZu2MlSWWDLKu/hF9jOdEiJugT/kjrMZZlxAyK+1Vkk53zORusYChggVSA9A7XlSiFFIsiFJK9d/UDG3pTWh3BDGthGJlSabez3OFFt0G72A+xGtXsQOBZYmFxsKNP1EvLvFMEm2jsW4iubcQlk3MdQP9KyQD5SckpuOzzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYLbkZcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYLbkZcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6371F000E9;
	Tue,  4 Aug 2026 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785879240;
	bh=apk2rpbpKzpxFbpe0yo9PJkIJJCFMtOmC66UWbHPNG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IYLbkZcmPHOYx6AlXTkSX6N39b7/IW61wp0p/uLje/4uTnYjhsD6JTizNgrohDlhZ
	 Qng3OUqCBG+5LQcJtfZq0yAkTGF7jGC2dqHA0QLHm9a8USQkBf5CIudjlVQycSHNDH
	 vdu5jhA/+8g6PR6nX9GZ5UuNt3mpqQSG8Qt8mcFnDcAjLo+kseNYbo45bz3K/CmaMH
	 33dRC771EgVaT+E1Zg7UaD3kKXSHCaELP7Vymt2TqLSvovtyaYuM8KOk+LiTAG51E8
	 sW7Qp9WrvAZ3H5Wy75O7pm8t/UfmYLmiI/9oS2yFb6Ja6CIs7kE+rPACLIpFhiQgGb
	 QMr7f74nQ7dcg==
Date: Tue, 4 Aug 2026 14:33:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thaison Phan <thaisonphan@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S . Miller "
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Fengyuan Gong
 <gfengyuan@google.com>, Stan Iliev <stani@google.com>, "=?UTF-8?B?QXNi?=
 =?UTF-8?B?asO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=" <ast@fiberby.net>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] tools: ynl: check alloc fails in generated
 code
Message-ID: <20260804143359.702b0237@kernel.org>
In-Reply-To: <20260803201652.2752685-3-thaisonphan@google.com>
References: <20260803201652.2752685-1-thaisonphan@google.com>
	<20260803201652.2752685-3-thaisonphan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 20:16:52 +0000 Thaison Phan wrote:
>      def _setter_lines(self, ri, member, presence):
> -        return [f"{presence} = len;",
> -                f"{member} = malloc({presence});",
> +        return [f"{member} = malloc(len);",
> +                f"if (!{member})",
> +                "return;",
> +                f"{presence} = len;",
>                  f'memcpy({member}, {self.c_name}, {presence});']

Silently eating errors in setters does not seem great, better to crash
and make it clear than things are not working than have a silently
misconfigured system?

AI also points out that setters are preceded by a free (in case we're
replacing existing attr, multiple sets on a single attr are allowed)
So if alloc fails we'll end up with NULL ptr and len from previous
allocation.

Maybe tackle the setters in a separate patch, and keep patch 2 scoped
to the easier case?
-- 
pw-bot: cr
