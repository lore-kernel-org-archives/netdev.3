Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC93E49EB;
	Fri, 11 Sep 2026 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094030; cv=none; b=Jp+9YAgl3gJ4iPp7qj9WBo1Oeu36DetqjzgFnjjFbrn8DpVcsDcxkyF/kj2O8cAxDebayGbvugU4GM5PH9/jgz588SybbK+bb3LzXNaXVo0YF13yxnDaefUyO/h9rVgF8aHYdO5HeRBhZibhNmNRS5+kGdjUS6tujlXp3LiTdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094030; c=relaxed/simple;
	bh=njqAFgi94df7VHwv2E+5qeV8DjVZph+kt1hFfhAbxd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/BFTalvVVgUzGZvjMbjbxmtzESJxHHR1yL/xfo89dP2NY9Llkp+kisl0DKQDYDeJM0uKpJPEpx71u+cTpUZ7LzfKjZptm3IQURiA2ts0euVIqFfw9M1xakQ8VbGdgHkRk4Svj83Wvc+aOmVJFDqzs1I7H3pr0oL52EticL2DFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP7fvsqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP7fvsqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D101F000FF;
	Fri, 11 Sep 2026 02:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789094029;
	bh=njqAFgi94df7VHwv2E+5qeV8DjVZph+kt1hFfhAbxd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LP7fvsqTtG0Sz2JS0VKjTSA2igBI8dhcL2i4PpwDcrNzCJ/MEQGdK3JFj08bGmiqU
	 DNu7WeVT6zhIilxrUOHsUaI+v4SGnaVJ/8om0rVnz4LR41iKvi2+3J0xrIAs6CmAUI
	 T2M3yuy+RwY9XJitSK4M3LVD+llUtgAye4QSG1s8Khl4hqkFV5R36J5LjuRiLkNuFZ
	 5e/zvMON+ee7l280kWJ2WKLWPRt8f36caVUtKDHfA3KrIlbnn64jD07ZbZqRXhWRPP
	 h0X0DIQg1LLPibpIYsGL3sOsj7NQOU+8JYbZv8sI1jQAk3/2R2F1/ue6XWM/xQkFzo
	 /TEkTQ/DYAjdA==
Date: Thu, 10 Sep 2026 19:33:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Danielle Ratson <danieller@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Greg Thelen
 <gthelen@google.com>, Ilya Maximets <i.maximets@ovn.org>, "Matthieu Baerts
 (Netdev Foundation)" <matttbe@kernel.org>, "Maxime Chevallier (Netdev
 Foundation)" <maxime.chevallier@bootlin.com>, Paolo Abeni
 <pabeni@redhat.com>, "Remy D. Farley" <one-d-wide@protonmail.com>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>, Heng
 Guo <heng.guo@windriver.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 3/8] tools: ynl: add C-based YNL linter
Message-ID: <20260910193348.2ded41aa@kernel.org>
In-Reply-To: <20260910221733.1021864-4-ast@fiberby.net>
References: <20260910221733.1021864-1-ast@fiberby.net>
	<20260910221733.1021864-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Sep 2026 22:17:23 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Validate that structures described in YNL match their C counterpart,
> currently focused on enums.

I don't see the point of this. LLMs will catch most of the problems
and for the hundredth time classic netlink is not the focus for YNL.
Anything genetlink can have YNL generate the code and uAPI so problems
do no exist.

Feel free to keep the code OOT and let's see if you can prove my
assertion wrong within a couple of release :)

If you have any ready fixes to the spec please post them.
I'm also sitting on a bunch of fixes based on LLM scans, I'm just
blocked on the "15 outstanding patches" limit :(
