Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72C29B77C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572050; cv=none; b=OPhuoGQ/ENOa7gg9xmouai8XTE/pAben41NqbSBxyifEBjY14VMEZpYB3j29dtJfSBuluFJPQVmEcZsO5dH7xx72plNxvANFcrSp9k1K2CNh9IPZ4zO4iXwJzWFBKaYmRFiGIP3ujUBDweWlQSUfOLdBinVIqBbnw5jz+Wcz/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572050; c=relaxed/simple;
	bh=YPHd+NClejOZnveRJvhokuM9j4us2LbwmKavhgw9Qr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1xRNh1fJgqudVLSB6xbmDYDmN0YfyH0d8M59bz6sBnzZiX46Mc2zzT1eg4Ig8cGJjTF4zhkdUKvtF9fGmElM3pUJ/FwTmqdf7xiaIASHLXkjW4odHkChBKrI8flCdh5K5mLA74Vv61iCblVbDFsbQh+jkU+b/LAqfW0vB1V+ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8C38460913; Tue, 07 Apr 2026 16:27:26 +0200 (CEST)
Date: Tue, 7 Apr 2026 16:27:26 +0200
From: Florian Westphal <fw@strlen.de>
To: pablo@netfilter.org
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 13/13] netfilter: ctnetlink: restrict expectfn
 to helper
Message-ID: <adUUTtWT8ITs83It@strlen.de>
References: <20260407141540.11549-1-fw@strlen.de>
 <20260407141540.11549-14-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407141540.11549-14-fw@strlen.de>

Florian Westphal <fw@strlen.de> wrote:
>  	list_for_each_entry_rcu(cur, &nf_ct_helper_expectfn_list, head) {
> -		if (!strcmp(cur->name, name)) {
> +		if ((cur->helper && !strcmp(cur->helper, helper)) ||
> +		    !strcmp(cur->name, name)) {

Sigh, I don't know why I did not see this earlier.  It looks wrong.

Should this be:

if ((cur->helper && strcmp(cur->helper, helper))
	continue; // skip, name doesn't match

if (!strcmp(cur->name, name)) {
 ...

as is, this restriction has no effect in case the requested
name matches?

AI suggests

if ((cur->helper && !strcmp(cur->helper, helper)) &&
   !strcmp(cur->name, name)) {

... but i think thats bogus too.  What to do?

Send v2 or do you want to followup later?
