Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106A36680E;
	Tue, 21 Jul 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645636; cv=none; b=nvBs6qAa3eTfRQUbu68cLP1mRqhLv00/XpGgp54TsfQG6ijnhfN2iY7mh3SI52sfaHv3925O5poMK4dH0QswW9XM2jTJu0IE661bzUgM8X2rs4AfFCLlxTD+IFY5ORyu6yFd4jhJMtnPAMP3YEfDt0O2EjM0v9Ds1YfwKbZppuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645636; c=relaxed/simple;
	bh=pm67Fd9supkZGOumXwvhXMfp13GiDK0p2Tc9tDugFUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gb5hXC8we2LL/lK9wZJHuNe1UKGRad1hF5OyjiDzhqILh1pGeqd/xxnNGOB2lPTiYh36fmAblT622VkF39+ng2qrkxmZfowmfAQvybbOSxz9fLl6yG9Bgo2a+we+DF/aF6stas1ajaz7msLiTiKgLQ4OWr7PFOE9YZ3052f4moY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyQ9blFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyQ9blFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169EC1F000E9;
	Tue, 21 Jul 2026 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784645635;
	bh=pm67Fd9supkZGOumXwvhXMfp13GiDK0p2Tc9tDugFUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DyQ9blFXMLvRGZJ5/QpD8tSbl319awSEwNrASBVPKLY0B7jVCW1y5DjI0d558QW2z
	 pYBdZ0OqlKcRUT09wZbwIeL+KXGXe7SRltKU0Kc3SafkwCdTcV8QKpKcUHHpKnLwfq
	 Vx/KBsiN4xwb7tp+5YwcQcFcuoeAq3AFlbgYXqneSAX7/HdwPV9f6WR3OnUEjCP+sr
	 zYmvRz+1Ji6fMpb/uimrSSbA7HpybbMu1OC2WQODAnxql906H3FSxHC+m3kBXKPBFg
	 95ZKmaLfvB60ot/oZr6vbIxv3+EOlbCyd/CyJ5/a2fYNeOtfLdrId5VZlcXBBDBGr/
	 4f58LqcZM2vhg==
Date: Tue, 21 Jul 2026 07:53:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: daniel.zahka@gmail.com, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, weibunny@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>
Subject: Re: [PATCH net v3] psp: fix NULL genl_sock deref race with
 concurrent netns teardown
Message-ID: <20260721075354.4f8830fe@kernel.org>
In-Reply-To: <20260715110701.3775026-1-kiran.kella@broadcom.com>
References: <20260715110701.3775026-1-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 04:07:01 -0700 Kiran Kella wrote:
> Subject: [PATCH net v3] psp: fix NULL genl_sock deref race with concurrent netns teardown

Missed this, same questions as v2:

https://lore.kernel.org/all/20260721075252.1d577783@kernel.org/
