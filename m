Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085124963CF
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601823; cv=none; b=Q5ptYFNsxZoMvvvk7LWZk1Z4Ucb+YG53XP6kzISfV9oyW7B7HirCMPQYsjBHzbGDUGDsOUyoyd2lt2nicAot52UMFaMbxWgxaRov4WDSdt4PLgcZtV+BihBJ13Q96p7gnhLTCE4VH+mjSwXjHc5s3NZI9dyTO8dK60n16FUhbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601823; c=relaxed/simple;
	bh=ucibx209KctR1iDBSi66h/i1XnyGb9G4ESaYIkHI+JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rzc7a0SlcfWq6PvhWYKb2+cC3VEnncJvx4c+IguwBAO0YLcezFmIutU2nIxadwks5enwsGd9/Oj+TFHQdkYuCE5GEY2ZxHYpwZsG6qobXbOs3+hNngKgY92/LpQ7yI6CQeWooWHOP+Zdykaj0YeNUgOikIFrxP04oTlyBa/fie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiORYFnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiORYFnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487D21F000FF;
	Wed, 16 Sep 2026 23:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601821;
	bh=ucibx209KctR1iDBSi66h/i1XnyGb9G4ESaYIkHI+JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aiORYFnDsVMmCqEJS8lKWcwH5cQtspyP+7+5ISXU19SeMlmtl56E09XEUOLlmccRl
	 nPbIJoewp5OQXK0obU+dBQgcxHZSRD4nj0CbGrMDM42pWAiCW9qUEli7mIPnYpAyKv
	 oQGc6lEkvN5OZizYowMMBzsIXVMRxkJRBvXRbYD92Yq2VFAUtzSaCQDlmV+KjtMlxw
	 U4rjM0MxzNL2nB3C8SLqKJhc0knoqp2RZXOByZJ7yALL8ntcE3Gy0u0QzCC78A52mk
	 qqunIL6DwAZ/WUVAZo/EQtNFGOPg1A4PvTidfvOQLIsW6IJgxFuV3wMx3WYwNFL33U
	 hgg89ob4cKA3Q==
Date: Wed, 16 Sep 2026 16:37:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, ivecera@redhat.com,
 milena.olech@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net] dpll: reject a reference sync pin which is not on
 the pin's dpll
Message-ID: <20260916163700.1fc4d654@kernel.org>
In-Reply-To: <20260915213047.1352286-1-kuba@kernel.org>
References: <20260915213047.1352286-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 14:30:47 -0700 Jakub Kicinski wrote:
> CC: vadim.fedorenko@linux.dev
> CC: arkadiusz.kubalewski@intel.com
> CC: jiri@resnulli.us
> CC: ivecera@redhat.com

How many maintainers does it take to get one ack? :/
