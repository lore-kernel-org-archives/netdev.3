Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7501A2C04
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790381638; cv=none; b=cpm2lW8VXWRY9Ij3Wt0iPQhZKYBRcUv/Gr6exjdO7a6dLSehkymjjOfd4lgP2N7LTgMF6r+b3JAHChAZqOE4ev5vM3tw4ecz314VMi75A01cLZkXmw5afNaC5wQK2YBptgv1c/C2QASeeps+Ht80yUVUJjV/QClFPzIiUBRxuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790381638; c=relaxed/simple;
	bh=8+aOiEHP3R51BcgX0m0tUIx5CLLABS16CGIIuaythYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqonuXK8tQaGDtBiw2rkjFkHpuUkC/bq6/ieHgzKNMvyjqcf5eBTEZNmxL7lHuhu0UivJ+klTG6G+i6J8nQkk4SRoJBiy+RmOI/0IjV03xaKBSnabcdheTyFgbmWRkv2oUG2LX9meoCHLA+1O5S88S9ATF0jdrgzUUHRJilLRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQfLq5WS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQfLq5WS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A663A1F000FF;
	Sat, 26 Sep 2026 00:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790381636;
	bh=8+aOiEHP3R51BcgX0m0tUIx5CLLABS16CGIIuaythYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XQfLq5WSzBXjYsyS+WuZiWWU2moVzIhXhHLPkCWyZc6OyVZAJKZffphW4rh6X+yWQ
	 N7h9jv9cd4efUWFhFB8XBNkLEyNG1UGYIcdr3lZSh877kSt1C+VZQ1YH9DpOofmiPT
	 Gw6vmpkH1HxUzHQtwOpzzIUNQ8+XLW6K0PEWO5K32Jc68HbxgAt/o0h6SN+Xp55HAd
	 GKLoaa0ZrS2gFW5cknGruKam+ygSla6YJCcNAAmza7GxQ6muqm+wpCVTpeJZAy7F9X
	 MDnsTfJq38dGDJWbw33NYATay2iZPiQ3IwALug2m4R5CqjXZk2oO/NKetfFgae4Rem
	 QnmmsEX/Glfjg==
Date: Fri, 25 Sep 2026 17:13:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jase <jase@nocloud.org>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 rkannoth@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
 linux-yocto@lists.yoctoproject.org
Subject: Re: [BUG] octeontx2-pf: RSS table size is set to 4 instead of 256
 entries
Message-ID: <20260925171356.5b0a561f@kernel.org>
In-Reply-To: <361df563-e29e-43bf-8806-24bdfefed33d@nocloud.org>
References: <361df563-e29e-43bf-8806-24bdfefed33d@nocloud.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 23:10:20 +0300 Jase wrote:
> Source-only checks on 2026-09-25 also find the same assignment and array
> declaration in torvalds/linux commit
> aa98230e410f0ed212b6788c46b1e4d49e0ff7ca. I have not boot-tested that
> upstream kernel, and have not established the first introducing commit.
> The current Yocto BSP branch tip, 27016c83488643e42007ca7a2cfc1ad632f5ab57,
> also still contains the faulty assignment (source check only).

Seems legit, please cook up a real patch submission?

> The attached one-line patch is proposed for review. The diagnosis and patch
> were prepared with AI assistance and validated on the physical device as
> summarized above.
