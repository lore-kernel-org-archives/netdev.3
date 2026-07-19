Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9D280331
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784502331; cv=none; b=AN+2/+P7IwbR8TO9GMQ4O0ZVB4s8mkAl9J0F9huRoyFMbaiLNj+jjAD6F2sYPRWFiLSRLsHk5KWDKF1zwVceBjjzwjVaCMJ3ZwP/Sz0wAWdTOWw9lv3i7SVKrK+PliGW3eM3ZfPHxFs2Fhn7gFodn73slPuw/XQWHXtGvWLIEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784502331; c=relaxed/simple;
	bh=3fxW+4gs9/iUpg+Fia7rQmQId5PnlfgU2NbSFgIflkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw79ndOAIfYIz0Re+7t4QtJ600g8yG/VZMggLxEwKMA1OgnpiblxcZa+NRIYIAB2CoO1M6oidb/7O3bVtCel2os8AVQlrHzwkxP6MYqlH98SQRelGEKyL9q4l5tEyV2UVwSoxrJWLIR6snbzf7B78ITyaIIbU6Q6EeR8weqSPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBszSJBP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBszSJBP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4925a778491so4880515e9.0
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784502329; x=1785107129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqPTbLt9S11oOXHynyNyI3hmcOTYHrhXVPfD1vKLcOE=;
        b=KBszSJBPnDGMgjzcdaeZfOZueIXmmyN5Vrd729b62QStjFKP+WnJrvev6gYxo6wAI8
         DrW5sSZG/9dSeJk4ThEMSi+hPJekTmcv0Vt1o354RABI535BWK7dzjNsUNu73kj5IU42
         zyEOpsIhUybZtq29JqM8zXydxsr0dDp5kujXHVNgdyXiwFDcxW1ZoYG1xFa+/0eYgxeG
         w6Lu+uWJCzSz0jk7weyqGZSwJk7uSzTkZGwxIgzq57Sm21RBfuJinSeyTpc1mqk6qUcg
         TqmhZuiyd14jAj1W1fFO0GdgLC/zuxFfhtVmcAQQm3GxznoEFdNZ/Cw+jfNO/mwoWTHM
         aupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784502329; x=1785107129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RqPTbLt9S11oOXHynyNyI3hmcOTYHrhXVPfD1vKLcOE=;
        b=jiUA8aQFZ1nFa1wtdqZhHX124klMe6wO64HgcyY6HqXr8V/JJsoboYYpx+pK6hQVVc
         C7/HQNm+EVszEE/QXlzgSKLu56WG/xLjP/DcTjYs80eyLrYbmyTHF4hDEz+kcL6Ee5AU
         ktzCtc9PyBF3zLKUY0BrnXNEXVlABpxs2VrLorWQbwZWO2Cb5XD/D4WE9CgEKucU/uMC
         bj5nl3U701Vy1F+Pgpp0Ho1v6Uui392YjC89DNrgG9B/sXnCd+1a2+x5o3EpQukOngvl
         VLOogrNWEWyRj9ofdNg18xqfm/ErSkObLSCjKut7F9DHchCkQvy8Fw2dsFjEY9mQaEMw
         J1Lg==
X-Forwarded-Encrypted: i=1; AHgh+RqGTiyAQ87SUFc3e2GQtfSw9R2Z4ZV8mz1nGD91JZbt5EXBJ59dE+SAxdViBocPuIn0X3+4/xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2b/bFuV1P0GUvpkw16/j2A87Yc75dcLURB92onEXGJOdWkJCp
	ZSH/D4oZlHXeKcso4AhjiFDRpzlXTnWKGKdHtfOlL9dudB18RuMhg/cz
X-Gm-Gg: AfdE7ckN9was1dX+X8M6jzXs3aavN6WwffR4x7jqJxoi5sSSSgePLyFfwJxrLVIPUIw
	b5IKAY1v86yvroLabm4BxzWeQ3dEPXv0YfUGrbSRu4R9el/lYntSSo0rUOa2xEBprqBqBSoFilf
	WeWrZnyAHMmmfrWu2BCUJwr4SOx5NSNDr8CJ9M3HzFRC3jeeaScISeqcrBD1vEJEw03E8U3kAf0
	lOxeSGBI8G7veP3/dPany0XAjm+N41uwKkCBSf/V7leS5lzcayOs1BJFEB4TEXygp6N0l+UWY89
	yqGXRPuit8lgwZQ9wERQZuNcGFFskTdLK9E1Kl7BgyT/5Ze5ENQAM6YEPMrvx5K7738NN850LY+
	kquaF0i8HhloT73mAB1rxwrV1ulEa0JOjRfOwC1tLUSjUvbn7SxisLkAWlo+7fP7NpqotviBSfb
	k/
X-Received: by 2002:a05:600c:1c23:b0:490:846d:4edf with SMTP id 5b1f17b1804b1-4954a3ebc81mr70524295e9.1.1784502328701;
        Sun, 19 Jul 2026 16:05:28 -0700 (PDT)
Received: from skbuf ([86.127.127.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49500sm25706213f8f.2.2026.07.19.16.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 16:05:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:04:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
Message-ID: <20260719230455.eaf7a4mlkx5l2uzd@skbuf>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <20260710-mv88e6xxx-ptp-fixes-v2-2-af97c38df247@padl.com>
 <20260719101241.xs4nz7r5bonb3qys@skbuf>
 <A59F16A0-6C6A-4CC3-A7F6-84B7DDAD14B2@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A59F16A0-6C6A-4CC3-A7F6-84B7DDAD14B2@padl.com>

On Sun, Jul 19, 2026 at 09:35:45PM +1000, Luke Howard wrote:
> 
> > We try to keep the data path protocol between the switch and the host
> > API compatible, and identifiable by /sys/class/net/<conduit>/dsa/tagging.
> > I would argue that the protocol where PTP timestamps are in registers,
> > vs where they are in PTP header reserved fields, vs where they are
> > appended as trailers, are 3 different protocols and should not be
> > presented as "edsa".
> 
> For context: I added ArrTSMode support because even with the PTP
> worker process priority bumped, ptp4l frequently missed RX timestamps.
> 
> I can add these as non-default tagging variants that can be selected
> by the user. "edsa-arrts-trailer" and "edsa-arrts-ptp-reserved”?

I guess that would be fine, except:
- worth clarifying that you're talking about the Reserved2 field (rather
  than Reserved1 or Reserved3)
- any reason justifying the introduction of "edsa-arrts-trailed", or
  would it be just for completeness? As a user, what would make me
  decide between "edsa-arrts-trailer" and "edsa-arrts-ptp-reserved2"?
