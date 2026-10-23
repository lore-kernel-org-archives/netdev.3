Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783649;
	b=P1FqPbFur/JZKx9IU/oTRssyZ5UZoPByn/rTsPDwOy4lbdB+6+rgEzzQ0YqUuQSw+DnS
	 rZx3pJpSzdlqrtRrfu3e/dtOwZvPPVyfK3lRGth3EaIkUDKuYQvNK6tOZRVrR7jeGRCjg
	 5joKuw/v1WQfzt51dbzJ3hn3dXqvJ02/KBA/w9/UVzkZIdZ/U9FnITGBEX/iwy+nJnAAc
	 Qkc+vVEly1bHg3rNpCuGa56tG7SvYAVtiRve1e597Ebp0Vgya3ocL21Qt/chlvfQ4lf6W
	 qqsY8rFk9jnFZW+T3k3WQY736dAk6WhYGELFiWB0CJCB80y8rI3auPrKZ0abJl5zD/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783649;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sTBmKOyJxHp3ZkFJHNlhEJ0e8u9To048AvTGnDjJQDk=;
	b=bb3octHO9TQoTY9wM/d+sLBKQbd7bDWH/uogkCpa3Dszloy9OefHb6aqbvgfnniYOVRs
	 rJHLij2NKV/SKYI0h76hQJvhu4HhJI5Cz+XE61JuDD6/NAlmqBbVqA4Ig92WCP9Hr7oMz
	 yK1VOVT2iiUz5MLMd1iX7JFYhDq6yu65t/VwGZ3Fqq6UHzxn0cC4t5QcnVwgsWZGZbG9E
	 0Uoc78Cjwvyu6qYZ6KdNPbVJQ3FzXiwqRu4UDP81E7UOPPjKOP/X66agfF5tMp8wgGchq
	 pCFp68VLNbIjskdZou65Nuj9M4SwBq5NCsw5+HgcEH4DLQMvENwSeiquExV7Uwm1tYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFHdGGtC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5FF606A31E;
	Fri, 23 Oct 2026 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFHdGGtC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2F41F01825;
	Fri, 23 Oct 2026 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783649;
	bh=sTBmKOyJxHp3ZkFJHNlhEJ0e8u9To048AvTGnDjJQDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hFHdGGtCgOywQjG4O5nypq/3INuAzy51l0mFc8eeD+23rJ7/CZ07H5lC1TFE15n+R
	 1jwfZTnhA6wQuMCiIkJro6ACuAnGy9R68vQ9x2zqsK/J9rlesCTsGY0aoc6Iif6AIx
	 Xz1mO31oMWrILv6bciU4Dy5b6WDeZaPGtdBcPec4XXhcrW1DfANOTRhZ/fUJUoMxHI
	 0PVp0EMyyLFEh768HXqFdXnrpL51QFNrPoXjCnnQKnOXj/MT932OfzmD2VrvUKsk+U
	 ZWf9uTpkDrh38YckFTjnCJUNw4VkLg1z26ru5Y8cziHlvaSJZYsNcqBM/E2bt91unG
	 coqw1+avel8aw==
Date: Fri, 23 Oct 2026 12:27:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nimal Prabudoss [C]" <nprabudoss@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jmeneghi@redhat.com, mschmidt@redhat.com,
 manishc@marvell.com, palok@marvell.com, spadol@marvell.com,
 jtaubepe@redhat.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for QLogic ETHERNET
 drivers
Message-ID: <20261023122728.0117d151@kernel.org>
In-Reply-To: <d1dcada0-9949-404e-b08a-7ed91d9d4e96@lunn.ch>
References: <20261023125409.1989-1-nprabudoss@marvell.com>
	<d1dcada0-9949-404e-b08a-7ed91d9d4e96@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 16:02:10 +0200 Andrew Lunn wrote:
> On Fri, Oct 23, 2026 at 06:24:08PM +0530, Nimal Prabudoss [C] wrote:
> > From: Nimal Prabudoss <nprabudoss@marvell.com>
> > 
> > Update maintainer list for BROADCOM BNX2 GIGABIT ETHERNET DRIVER
> > and QLOGIC QL4xxx ETHERNET DRIVER to reflect current team structure.  
> 
> Why Cc: the scsi list? Who do you expect to actually merge this?
> 
> >  BROADCOM BNX2 GIGABIT ETHERNET DRIVER
> > -M:	Rasesh Mody <rmody@marvell.com>
> > +M:	Nimal Prabudoss <nprabudoss@marvell.com>
> > +M:	Sharad Padol <spadol@marvell.com>  
> 
> ~/linux/drivers/net/ethernet/broadcom$ git log --pretty=format:"%an" bnx2* | grep "Nimal"
> ~/linux/drivers/net/ethernet/broadcom$ git log --pretty=format:"%an" bnx2* | grep "Sharad"
> ~/linux/drivers/net/ethernet/broadcom$ git log --pretty=format:"%an" bnx2* | grep "Rasesh"
> Rasesh Mody
> Rasesh Mody
> Rasesh Mody
> 
> We generally want Maintainers who have shown they can do the work,
> posted patches, answered questions, know Mainline processes, and don't
> spam other lists etc.
> 
> Maybe it would be better to leave it without Maintainers, at least
> until you have reach the level Rasesh Mody achieved.

Yup, please see the documentation if in doubt

https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
