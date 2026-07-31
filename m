Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30F35893;
	Fri, 31 Jul 2026 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461399; cv=none; b=uJHnmRVDoOpjXZnYkfpDfVddB4pd7Y76djaJAXejzizKTU8BXdLjW5fEZPO4AiTB4NEzKONGfwelCx20kemWb2TmeVXLy6fR+AdpLrV7mDYPK5I3VJXJRka/ujuVGukAduMTJYcuGkHo201hjHRkZMzGw0Vey0YcjDH6MGBIeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461399; c=relaxed/simple;
	bh=w9tICDv5WEnrh/B9Q3WmvZeRdO1H6QsbpBrE4XJhRns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD+tUVwR9xSGPjV4WGyBREfBU2ay0n64zqYNZoWV8jPM2cELuB4ZIy5sC68JSv5/HqzzpRUlcrF/hOB2tU3hRBWMrKf/0iMwF+/34lwSuLw0ITaGukE9WVVXswGs35mI1zEXPBcvcRCR9eiM9fZAdjIZYDm4IMCQIXn7S2TKijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgfl7CTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgfl7CTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1FE1F000E9;
	Fri, 31 Jul 2026 01:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461398;
	bh=xnmGrTLo9zTF52/Bozj+v4Q0oGC/y7QnKsSmt0rzzw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qgfl7CTgu3lG8Yp0T7wVSyC94jql/f0TWZfS6SiRBVktGHHhYBGMVLTaCtyARqeb6
	 xkyYky9izp23xh+rG/yU1HVBFuX37xlBySWZrui4txcJRojnaILCMIaM0XwUzKWS7G
	 d60X7olBLPbDPaKwINxjnBDqzkp8fshNxjFImC+HGFnZDqDGY82tRLionVuaqBVS0S
	 pLjKoi4xBYQqeVegKfJGkDZhhZKWn0NTysGclTM7axVw1cJkJF6gF3iTMj5ccd1/H7
	 mLNOPHiR2DZyCKcXpwiIN/MfNHVNYQ+23IldOKt4W3Ieacen+bghmXTlzjOXlh+CJm
	 /hVs/QSOjdQtA==
Date: Thu, 30 Jul 2026 18:29:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v22 net-next 00/12] nbl driver for Nebulamatrix NICs
Message-ID: <20260730182956.5cbe613a@kernel.org>
In-Reply-To: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
References: <20260723040110.91410-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 12:00:52 +0800 illusion.wang wrote:
> This patch series represents the first phase. We plan to integrate it in
> two phases: the first phase covers mailbox and chip configuration,
> while the second phase involves net dev configuration.
> Together, they will provide basic PF-based Ethernet port transmission and
> reception capabilities.
> 
> After that, we will consider other features, such as ethtool support,
> flow management, adminq messaging, VF support, debugfs support, etc.

There's a large number of abstractions in this series with a single
implementation. It'd help review if those were removed until they are
actually needed.
