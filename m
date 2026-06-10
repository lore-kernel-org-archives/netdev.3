Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045BD429837;
	Wed, 10 Jun 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106508; cv=none; b=cojXCaXzlj669LcKTO9zQumQ5A5GwPP1SIXfw8CvVt6RFx2n50JUB5f1SSMeSnVJdT7OsHKKV6TnvKSGKGgz8kiY+9aaqwd2IaUndZaiSSLunNEmdlHlZOM0oUOAYj51dH4KXo1PHnVzKBbxACs8uWs+wTK1CGYxuNdjk2ILeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106508; c=relaxed/simple;
	bh=vBSZXlYTYa8gUFt8i8CM/TCTv4YvGJGdZHDtvTdzOKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8i1nEZ1WvnY5tGeBfkd2bMtNP/wFJW8ZIsBhVCnOhE6sZ0FNj6VEtIasr1lQYg/u7nihXbOAV6yDk0IV1iP06Ce59TEdJS7Wu6M9SLKMlVZxOvOpZkp61rM0OtABcmcP+GD43MV95qsRnJ4HiH7sLF7/fubsJEn8FO5T2DI7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBoVOjgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBoVOjgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE7B1F00893;
	Wed, 10 Jun 2026 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106506;
	bh=TiIuQa9FIBdiIlsUSZ+64tG5w7NNmkmX2Fc5YpYWNHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hBoVOjgyoUNL+AYU/nJ8mhyInQZctEsdhJ2cWmIhc21m/yfUec5mr58ifA2FV5XRA
	 7AfXrc8kI1pLA6mu4vqB8/jddvL06LSZdIN3+q91ywiWK6mM7qpb30HhRd4K729P9E
	 NfxkdDxHSFWHCHVoTgzXXASPKdvWCUXHz5kfN1DmWBFnUciPyCNbPafH1mupbPohaY
	 JsojHH3Dm/U5pgFaOIXJtUEO4jQD5maIQswkuyxV5uNL/cSzEFcRFHaZWOsYCaby7e
	 YPl1LPCraazAH3F1kYPssIdJ5vyirQxfXcvxMxT7egHY0/y0tz5drxRRmFq10cKFq+
	 n3IbjIo4lmBdQ==
Date: Wed, 10 Jun 2026 08:48:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: NFC for next-20260609
Message-ID: <20260610084825.64763972@kernel.org>
In-Reply-To: <b3084b2a-f8fa-4bba-8a92-1a14fbacb622@ixit.cz>
References: <b3084b2a-f8fa-4bba-8a92-1a14fbacb622@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 10:45:21 +0200 David Heidelberg wrote:
> The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:
> 
>    Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

This should be based on net-next if you're sending a PR to net-next.

Normal flow of history is something like:

 net-next - x - x - ... - x - merge - x - ...
          \                  /     \
           `- x - x - x - x [PR]    ` x - ...

Note that net and net-next do the same dance of periodic merges,
and net does a periodic dance with Linus's tree, which is how
we get changes propagate from the tree with fixes to -next trees.

Problem 2 - the subject says next but the tag says "nfc pull request
for net:", which one is it? :)
    ^^^

Could you rebase the patches on top of net-next if that's your intended
target or net if you meant net?
