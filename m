Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793785622;
	b=QM+38rJ/Z2zq2PIDjhCl9hICSZpFgJ+LS1Tua0YBecvb3IL/BQDlQcJEodZ0+qzdIdCh
	 Py8sBgeFysOAjm4pyk8nVQYJnVuLz9Jntz/gPO9WFvr36DWpXbH225TiIqc/mtzSvg54v
	 4FH9/0tPOD+N1RoH9nLkDrm3ENeH+aWGTmg5ydblEqk6QTK3qZ0oaS77s/qLRB/J5LOAo
	 37XWcKdnlccu/h+UCKzRqZUCmOoPW9M/24AYb2wYOhY5TvjYnAFUqhE87tJO6t6f3F+kJ
	 T2tititpX1AMPTtSUPAd1xqI+1l/gG7RGryJ/g2E2R9cCTUGMIYlI2rBCqlaYKcpdhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XN5Sh2oQBbGY7k0dXGAYdV4jnNut/n5mRreEmSnndEc=;
	b=C9wssrAIPJMMTL/76LUvfOhmaTBedlMe9X/pwG3RafLetR2L6ZebYhX7B7/fwrhl3iSA
	 vgUs+o73eSsLcJVw9RrKrNyF6xw80c23oglHoFiaNpHNymHyQoKY8ZdP7/iaebA0sMwV0
	 P3ZSSamj9uXs8Pz1aNyPnmtdDGQgI2ACkr1it3wUY8nQp2EPPoP90fQeVh0HBnK8VfS9X
	 x8WoJNLYTUE7c4DR1WDG7Y+tiqKuOlLNrV4h1IFKAqXUD6rAZ55LlO7NW+Laut5cfgYoz
	 bjZanTbVoS2bEcGcbNMcK+dVmwTG/zxlayedfH2n0cttqnQnVys+Bj/YT9RXPr0hhqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B09606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3B09606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so4036571fa.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793785616; cv=none;
        d=google.com; s=arc-20260327;
        b=LV9+E0ITjR3XDWTLFNYe93lP2KW+sB9+3W9S2ywCEjWKC/vtI0FRpO+/D9SBgCTpk2
         xAuIt0x2YAEUpEJ+UVgjVNK1yB3j1Jt9e1Yiu9gxxA80XldJO6fDKjdMF3TuzG1w4ujm
         jwmAwP9h4CRRMPNuX6W9PGPUF5hFLHx0UNPIASlk98N653FkmFZKS6eOI1wp8ikShfwM
         UqnTy4tyvsyGBzhWXO1iWNN38mn2MgEOdepxIq+FbzT5HY9AgwiXGwpEvRP1K4zbTYIK
         dC/bz6i39sxR7vcNnIhBErb1MFkzW+KaZZSgatJYGNUGzdAGcxPD4i0vWMKa7ycBbwc9
         aCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XN5Sh2oQBbGY7k0dXGAYdV4jnNut/n5mRreEmSnndEc=;
        fh=uqdpZv/tKF98pv3/0GRLUzZ38VcdUyADU9YhaTK5LGg=;
        b=YqmqJ/gYWzEv6/vGlnh6pv+Hnrwe5P9rO9SPjKFQHomIBfQvSc3PgnmU9DZm/sgwuP
         EExzk3OBonmQZ/dK9Ouoimtok3ZlPDz5MoKSWM8AJpHtaDXtNhb3/A2QaDtisz8XmacE
         k6rcTw612f1oG/pJVDAe/gCiefByxUmdXVp0u2aPC3ZnAwJ9pQD90c3uqPn4484PQRMA
         9GPWDA813KDSPhakT/aG49KBhKqwQTLDYudUc81tnuee3la/OIAwoW7lCAEaFx3ZllfE
         a8croXSZn6oinx4M8JmJnBZaeNlL0f4IXPAitPOVjRmiVh5kqT23flZHFpSl2U0oXkSJ
         4dVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785616; x=1794390416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XN5Sh2oQBbGY7k0dXGAYdV4jnNut/n5mRreEmSnndEc=;
        b=ueaoezkFWsaFRvCtcWwvBELUN2z1kEU6pSF31Wf0DG1JHxjJdspmttLJKxOmF3XONp
         1y1CdR4CvzVbWNHHVPkh8cPwb2I5Mm2fE6T3sekEUG0Dx6UrHPsnn3/GcpXIWt0V9WVM
         RfcOG6etdiGPzA9yW6C4MwQM8X+kb6aRo0tRP6+UVkBLFjW/MomIfju0fdu8fuBELYn7
         k7oliHAk/xRWeq6p4gHK7cMoyD9/0433dzmmPle8tH2kH/C/rLoSjDDhachl0v2EU5Ht
         nQCZbrZWmxDTmcJYGGNN/ZqeBzCzKWhHuursCmMMCsIO/AbSTND3/ouvJJLAe6A6x1QS
         wJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785616; x=1794390416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XN5Sh2oQBbGY7k0dXGAYdV4jnNut/n5mRreEmSnndEc=;
        b=dqCzOG6WTapNXxuXRo0KyqUGOyMtHKLHCFwAR9jM6UEPHHVp98NBmOK3Oxy7lScbDS
         7YwJOjCL5eQH8tPHPkdL6t/jqKc8RRHSUtm8ZKU7NMszViW5l1JE1mxxqrhvTtkflNpY
         AMtnQxReobw1eX61hgpwk8xHFMkotI4SIJzTeWfbGqr4LSdDUH4r2SHpAJoAclOv8Ovk
         aBGgf7wmMiyT1heqQx0OA4skr1UGQ2FZtNGZzVuCR0VhPO4ri9Vz1gdzUg1ED/NXq0/5
         RWRRjrowJ+Xg1SlATCqERaDzaq5GSwlj3ew8wki9FRsyNP6tnC+cNMXc64UquXtRWak/
         MVXg==
X-Forwarded-Encrypted: i=1; AKwUvBzR5ARQTnYHLE/CCe3NL+jINxQzYbGLXL3GFal2Fa0U2iMFBtwpaP135veYbPEy6x5xW8W/DaE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BDL9rLIK0mgRMKJz3jf8KabonKK29HNGtfJtnwe9Cf3MXvqhd
	/c03NEQX8AulgrWza5aq7EWpZfnYVZA0pyprOyz9xCu330CL85vFGM/NyQ2O9ue7SjXD4OunlN1
	sKP6VhAo9dsLG7Chk6bbeBAKnIZLff20=
X-Gm-Gg: AYBFou2Um9lvLsP3o99II5VFqaLIrSDVl3CskpMwp5MJCcqoVQzNTGL/z0EhEI9tMAB
	8iT842Hy8UC/IA7ZVce0jT+XE7WjoWebwyJmVMy1PljbJdlUvq8Y66BRbjMDRxSUPVyYuLK2tla
	3QH0vlU0TEklNZQttMnznf9Vk67rLlv1/Ys/WEmx3P7zimj28wxD1qTs5MTvjo4rSnRJ6UI/Bf6
	mP1J5LMmE5rb6pK1dIRmTDq4W7S+sgVJfv339v/uDQbfedznZN20NYtc9YosdpB58vVGW/FZSrL
	BOUQwIkuO7e5V+bG3d6DY/LYo3S/BcnZqcLYW3WApPCwqEhnPkBgdK9c361s5OnGrejoSZht3nx
	DA5pexBqBZVlIBs+blzIBaufUUXcxnW5R96A=
X-Received: by 2002:a05:651c:554:b0:3ab:2d74:71e with SMTP id
 38308e7fff4ca-3acb7aa68e6mr34698191fa.10.1793785615870; Wed, 04 Nov 2026
 01:46:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104013139.1341582-1-bobby.prani@gmail.com> <750560f3-4c5a-44fe-b72a-0611be383f32@kernel.org>
In-Reply-To: <750560f3-4c5a-44fe-b72a-0611be383f32@kernel.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 4 Nov 2026 01:46:29 -0800
X-Gm-Features: AclHuK_952V20K0MdX2zFJG6-rtCJoctiobjvK9UdyxPOe36f3zxfg36adJewT0
Message-ID: <CAJhHMCCu8ehOU37_4UpExNO3U8YPygjnht+2S+axkxTwY8bx2w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/rmap: use release ordering for small-folio
 mapcount removal
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, 
	"open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thank you for looking at the patch.

On Wed, Nov 4, 2026 at 1:16=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
>
> > In an arm64 page map/unmap microbenchmark with 20,480 minor
> > faults, simulated cycles fell by 1.54%.
>
> Thanks for the patch.
>
> While I see value, I am not convinced this is the right time for this
> micro-optimization while we are busy with other things.
>
> This needs a better evaluation: 1.54% in a micro-benchmark without knowin=
g the
> stddev isn't particularly helpful.
>

This result is from a deterministic simulation, hence no stddev.

--=20
Pranith
