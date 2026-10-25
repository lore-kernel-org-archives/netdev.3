Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792896790;
	b=sdjFG67Wc6gkjfsUDPhXzVnjzNPxp8KFoum0iE3AGuf1JIQXb8MAUSZPZd4EVNn3MF3K
	 MhI1MXV60AVvm0bnITyi+WwNcMq/8smAoxkyQ7vD9mLVOo93byfAlaJ7yhkGkTLt3nbAI
	 nBJGxUYiHGJndoZ7tdWcLN9RFxggK75n3WAtI3LEQY0W64PRAIaS9ysazn4pD+Kspe7zO
	 Kx4U/sY6IeBtnoVDLCBeP1dCghqyVNF14E4GUzxNdTVjjg9txveljqaf64bNksbJSPyqD
	 BrwzViYbxhV6SQKqEpvuyPSbRT5ZbGGGDqJkzIp/6Xd/davoQLQujqUmnvzJDGM1dmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jHGtF+NZaI+hhPHPeZP23JdzKtyfeu2RME20H6dVyog=;
	b=rmYVS3ol640b8jWe+izpIigvz7pnybkhl1tqfdwlLxrMJpxo8HpCCHalvZjwxF+9yyNG
	 ojpzdLmobVzVNYcb4q4BB3c+C3+lQlGkAqMNbTX6U4+/p0892+s5EDSEUvgd8DHwF8ha8
	 m0USBcu2CK6cUl6oae3CgrG0FyPY+OHf4OtaVplQF529Kvixa1A9x+Ha5Tx3LIxZvtarV
	 FWoS90VLCwwz9UwA+/JqrLBdJXLTlxjkhSNot0PN7QCxYfN0ZwLpgV9pdsOEUaSOZJ4h/
	 /oiPa4QqTyGRaV7PH3xACvI7C7uHJI56uYSe6sme7V+Un0uZLp0PoyWlb339Q0fnOQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=GwcUEZjb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BF606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=GwcUEZjb
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so3393591c88.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 19:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792896788; cv=none;
        d=google.com; s=arc-20260327;
        b=p5BiQ2peWcaKdIO82+IKa2qJ5OSvIk2A4+a8S7V/qq9pnn316cRivjSSlSsuRvHY/A
         HlzIfF9OAfZYFdZ3av4yu0xruK5q6fhD7sqUEu5jYBuHSoMbNDOnUNSiiwMqVfUU9d4x
         tWTuzJj2kEdU4/rc3T6BrJHTi/d5woUj60xriMu360Wl8YPfIAEdDVWceZlByQy4AQQb
         isfrPyHswNHhc+S6bMc+vG8tuQZHooWaPYE0+I/rT6zAB/S4AbtuCFo7TH+5QAKNSdk+
         XQN/yGIQaWAKimHR4oIUPC+tiaOgAFqY3vck4d+BbTf+aZNnzuKsBWvLclqBqrENlIsI
         eHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jHGtF+NZaI+hhPHPeZP23JdzKtyfeu2RME20H6dVyog=;
        fh=hB2f+t9aWtHlJsqRCqtL6ZyfkAACPyvT/D4I5zqSGao=;
        b=pkLQOv1iukW4VPTdSEDRWJG/ekCrSXV9Krp+w7cS499/zBrzC1njigo78NGtF6xG+c
         8b43DiV+T5woiiX+Dc0kgH2olGCk9+oBIxxq4LDMuSI1g6TW2d73OOhFZ5K6eUEKMiA0
         GXhnZNMN5T+rsF+NSPj6iIUxRoi4hfeDGkm+Gv/A6GokgrjsRiYaCWn0LWgWbVHltcBF
         VhliBRwbZ9YNvwddyc6unODHU7bp9pM94JySZ0qVgngGkDEOrGbCrD//j8IT01782ZkD
         TgWDePg8eC986u0yyFdBAZwIqARvDwfQq7UK0mT2QzcaXemmmSAAUjzhrDbfPhUe4oM8
         Ivew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792896788; x=1793501588; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jHGtF+NZaI+hhPHPeZP23JdzKtyfeu2RME20H6dVyog=;
        b=GwcUEZjbtQYEBYkG+EKGOefzT9NTXUQB6xwcN0B/cqwwm4qgN4m0Th2Ovyan1vAn7J
         2vYqZIZoV/jA3RUO6UcMoiRTfDbwFGjxmUTwLnpjvoelEptoc7YDN/BkPZOsoF+ukW9Z
         PPBvbX7i5ysIE1CZ79IfHFecG9MJEyBMnbGhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896788; x=1793501588;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jHGtF+NZaI+hhPHPeZP23JdzKtyfeu2RME20H6dVyog=;
        b=k9onJf59tn27UBRzWR98YVPYqCUe2P9bDI/qPZSmP+9ecF2r81EkC7Piz2U3DJm825
         7qfF0YlVBvRkpcieF9EDfNPMgW4dAUtBcM8A5oYOGYzfA6N3pC12zvUMSesBPiMVR2zn
         3u3JDcDkgmUMWNMzb2mL+G0WA4cGv1/Zc6Sj4e3N2nPvEq0AKCTL6ubCF4mauNrsFMBk
         aIqTK/ofTbVGnRDW79+qHhDfJ2LxPF667F2T9+DPgKwVHeOYOe/UyPn7YwoVd7167ya4
         PNwMJ/Z0AP+d7MkhTGsCfWmM6h9+eryY59R7gt0Dzh9GFpfB6MK/GdOKSQLtYRpelIjd
         aLSg==
X-Forwarded-Encrypted: i=1; AKwUvBxgFdqMCcYl6KDvXZjuhB0soBr7y016UkESAsYXkqccznCfyOX8Sa94q5K/BHrNy3IpiUKDo84=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnlqWOYXFjCzpmVV1TrTek59ALR3YByjwFisyMJPQkoWlrm4aX
	lnMIzqGJSqn6vJVqrOGHvkhWohYwnA0vkktEhG7dkw5Y4SKNNROjtffHOK+iAGfJAlHoemo1eEY
	O0EeyMVss5cdayu6Z8bd5h+4iUyj9GD3Bgy6qOjvI9w==
X-Gm-Gg: AYBFou1OP82sDmmiFuG8B6BvHPSboGaKuzhuxxszEzTQ5MeV/0mpyPJR2zu3heG9GER
	QUj66PSsVtfk7iKCwDXnZogUXPoUW6MgmnNLpDIUbKJH9pQ7APz/qycxWdHt/+HGGiYQUM9JMpV
	kxerM7cNKClCz1ECDae3MSNH32/DH2gsaMujzHzgYKCjDThdMLo3ii/fZ14VopnNN8mDdmofpLi
	9b5eHIKX7nyc2PkyWEMHzY/SorTqhu4UTov91/dfEgFwTI0OFT3l0wi2iZk9tRJgZtW07wqT0ab
	JJUkqn34Wpq/V5d3chMETN8TdQzOeOHPzEFVEvRsMQuRNo08ejt/GZbK33fEH7vDQcWDdP371F3
	YydoDmAxh13XKMAN1HQUN7N+se5Q7pmQQ+4sI
X-Received: by 2002:a05:7022:b04c:b0:163:3bcd:e5e6 with SMTP id
 a92af1059eb24-19934a96f4fmr5011598c88.24.1792896788514; Sat, 24 Oct 2026
 19:53:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025024514.802862-1-daniel@0x0f.com> <179289664421.3327.13269797237144711675@kernel.org>
In-Reply-To: <179289664421.3327.13269797237144711675@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 25 Oct 2026 11:52:57 +0900
X-Gm-Features: AclHuK-izwE4tuQ9_k56qieEjJy4dAKE5drC7e2460UfCl4uONeoDil9BFT3OsI
Message-ID: <CAFr9PXk93VVxotS-C90Rhi+uuk0BJngTAoMVQqWkfh5dRCbdcw@mail.gmail.com>
Subject: Re: [PATCH] net: i825xx: 82596: use MMIO accessors for the MVME16x
 PORT/CA registers
To: netdev-bot+sinfo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	Denis Ahrens <denis@h3q.com>
Content-Type: text/plain; charset="UTF-8"

Hello bot,

On Sun, 25 Oct 2026 at 11:50, <netdev-bot+sinfo@kernel.org> wrote:
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

A version of this was tested on MVME177 by Dennis. Dennis will
hopefully test this version on his board and reply with a Tested-by
tag.
