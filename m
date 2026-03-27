Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6B2C11D5;
	Fri, 27 Mar 2026 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774655955; cv=none; b=eTuboCLNaGp4BDfQ3/nGEVfs7UrdY1QW4qJuxQQPB5xFuDFITQkMyHU7rpyvJO3PU4zvCepEsGL4Ow9YXAkuo5nY6bSV7WOmRC4locKn/+NDF+VHjMHYMZgtG2mCmNiyMfSNsoAtbCKjA2Yp2bQVAgmMxZjDA5TUDC+DNq8Wdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774655955; c=relaxed/simple;
	bh=9VVortFFpNPznGxJHVeHeM/+hckMd7N8DVlBC6tbOTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dvkkr6BecJRVxg5bVab9+rTllfH5uOK79xVUIjjfA817as4iXjjausKkv/gmEUb8TSOdoVLeCKs6yx7yoUJ1EofuCkChfvlhGi8s7b3uc6g1dwyF9HjUTKclpz9VgFNu8b776vQGobRtqLuK03oVh7lLM35FBZl01o22gghXUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frd6Reyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frd6Reyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F13C19423;
	Fri, 27 Mar 2026 23:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774655955;
	bh=9VVortFFpNPznGxJHVeHeM/+hckMd7N8DVlBC6tbOTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=frd6Reyo2pqEFk/7y3Zha9j76Dj1kkDXwIbUeTTGhOZaH558XXK8nbbh9LQbJ7XEh
	 EocbdMrJVt3MJu8k4qfalyG2CbmeXoI3dMt/yHcmcxqOXYHAyQo7GKolKFiU7M0ipy
	 zTnZA+iVQiNe+F7iCWDliOYued9zN2XD2Z1SOaEP5uIwf7raw/wEjFS3e0G0yH+8nJ
	 LESu+hAro1ny1TR8NE2s6SwFxxKOcmd2vEMyobxPHRqN7q2jyDXTd792/Y0mVTCFIg
	 l0sLcw+7nG9/wuhWi5Ut9kNtY63oiMbMzvemVV/fhUwATJc1IgrI5tMhcg3z/l5Z0J
	 inJ4xDBQ0SnLQ==
Date: Fri, 27 Mar 2026 16:59:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Prathosh.Satish@microchip.com>, <ivecera@redhat.com>
Cc: <netdev@vger.kernel.org>, <arkadiusz.kubalewski@intel.com>,
 <jiri@resnulli.us>, <mschmidt@redhat.com>, <poros@redhat.com>,
 <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
 <linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>,
 <krzk+dt@kernel.org>, <robh@kernel.org>, <devicetree@vger.kernel.org>,
 <pvaanane@redhat.com>
Subject: Re: [PATCH net-next 3/5] dpll: zl3073x: add ref sync and output
 clock type helpers
Message-ID: <20260327165913.37642642@kernel.org>
In-Reply-To: <CY5PR11MB64621FF7F9F8E5EF85C7057EEC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
	<20260319174826.7623-4-ivecera@redhat.com>
	<CY5PR11MB64621FF7F9F8E5EF85C7057EEC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 15:35:13 +0000 Prathosh.Satish@microchip.com wrote:
> Reviewed-by: prathosh.satish@microchip.com

That's not a correct format for a review tag, and you need to
make sure that the quoted lines are prefixed with >
Outlook style quoting does not work, it makes patchwork think
that you added all the tags that were in the quoted text again.

Ivan, could you sort this out and repost (add corrected tags from
Prathosh)? Last time I tried to fix such mess while applying it ended
poorly :(
