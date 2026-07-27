Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3062C15BB;
	Mon, 27 Jul 2026 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195858; cv=none; b=OyrtXQ4LxDZh6IP3oWDmH2GaQ0eFG4ht8CmURZerayhnWVzR2rp26UjWg9IGZw4HAFc5wnz5a7YV5kkXTs9WKTVWjZVW0LAquY/vtSfET2kB0CO8xA3Q0qdYyUUMtBct/f/re6cXxzOxPPYt84D6q5pyI1SqqsbTPW+Lfe9FRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195858; c=relaxed/simple;
	bh=Rg8zAjsDqdYTZ5snzup8VqlmzlqHuhEQjTrHKdAxQVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBG/w5CvfruEbEy5q8QHOBUdfoWjQERwpSHJqy2EXc4zmRExwzvf44KYygRYXODqySlNwv9PE+F682LjB4mxQGDnxHaekhKQarYE5T1698TU0BSNgnvAIShhuqMW2F8x3PhkR+YpJfVsI78Htn8i1PyEx+eb3gQrTF/R+CRpwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkuzGnVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkuzGnVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821591F000E9;
	Mon, 27 Jul 2026 23:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195856;
	bh=OrI3AWor3wjL+wY/8pscrVbRp8o4aDq+lBAl9Kk3kws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OkuzGnVxCi5zd/JSH3d6lodW5e1QFIjZAj5fdbLRtk3hgfaAs+MntPiNxZrgZZTi1
	 mPeJIO6ipA/VVVONQGCxxI9dadixhq1VmljlfOidfFzMJHaLAw4eIEo4OSn1hDZ3B1
	 bTGRIIT84Z+xwYxFtKgKbTUkoSP3Qk7ATvrm80YHoWkYSxR789BLmbxcTeI/YE7xro
	 N470L0tU1TFKs8gD9O09yKU+MB7dCVFY99kWEbRd2L3+PcORvN5rHsy7jjaaZTjoBA
	 eYXeZYla80P2I4RSO+cLWXR8AeyUBSIchpedc6lVxVj13ZYAk9xTIHx11xHphzWHNP
	 1srZrPMcMwziQ==
Date: Mon, 27 Jul 2026 16:44:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 0/8] net: dsa: mt7530: modernise register
 access and add two DSA ops
Message-ID: <20260727164415.7181b193@kernel.org>
In-Reply-To: <cover.1784481922.git.daniel@makrotopia.org>
References: <cover.1784481922.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 18:33:45 +0100 Daniel Golle wrote:
> v4:
>  * rebase onto current net-next
>  * 5/8: zero the read-back buffer in mt7530_regmap_read() instead of
>    initialising the result variables at every call site, as suggested
>    by Jakub
>  * 6/8: keep MT753X_CTRL_PHY_ADDR() as plain address arithmetic rather
>    than converting it to FIELD_PREP() as suggested in review: the macro
>    computes the MDIO bus address of the switch PHYs, used as the addr
>    argument of bus->read/write and as an iterator base in
>    mt7530_setup_mdio(), not a hardware register field

Looks like this needs another rebase

BTW Sashiko is still complaining about corner cases of patch 5:
https://sashiko.dev/#/patchset/16c17477dc9eea8054455ef0e444a687336ced70.1784481922.git.daniel@makrotopia.org
