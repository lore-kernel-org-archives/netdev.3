Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354847;
	b=J0/7hdXZCGxhaz/pI7kfPNf/26E3xiuk/WHkrNNgfPRvBOHdMzGmw7d9/5ZX7eU/e+AR
	 BTdfyJm1ODc02mLEOgHPrGAqO/d08HznRoL+8ZVF4Npk4n4ppwaJVQba+OXuHzXi0py/s
	 EMfkPBuHjqgBg25yyLBprgyfKzcXWHOzs3/3bT5F8G962fVwre9KijMZ5Ni/BYQUPpP0u
	 ok+udeg71/vddOBaHgNZhxDDobs8YOY+TMGFdG99ZB3rYAuXauGQKKNZ1nKqZGqzIj/wS
	 xfv1Qjd3i7spt98j4Hy6MHLYa0RQmoObZuNVK+F2R5PPeeqKGzgPdEUR3aq5JzFGV9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2d8xjP5r+JVIA4NnCjXwCKt2E+WzV1EK+VugnrMgol8=;
	b=Ql7AfLmsbkvmZZEvjSztjReJHtW/5Qer3PqNYmJ2V/gAhILv2Rgh7MzbIph8EWHUYUFr
	 nGyUXEy9rGRvhBX+SKSlZLwO77/jvvkqJcR+xhGjBnqbqQJC0WCRRTuVToxZb28mkVd+g
	 TpVH3ECt+FfDZE9sGRqVLEdnPCxhQBgRK2pwNtfgXWuGx1BJRls+3ON+xdKeo4RKhivDx
	 rxYtR35aAO2w8bafNu17jJqtkd8qU3oO4SZ3N4DClFR8dXLyTuEX9ChWqfZY2QC27Hhsj
	 x4j1olB00dGf+o1RgHNWovkVkfxwfNyVhKrfp0HgYfL9PickebXqclGmA9KoJi+RIAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OumB8stl;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3A606A320
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD3A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OumB8stl
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5364042eecfso32424691cf.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354845; x=1794959645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2d8xjP5r+JVIA4NnCjXwCKt2E+WzV1EK+VugnrMgol8=;
        b=OumB8stlEQNw4k20Fil1mn05/tVHvxxuppK3HENY7thCNHl6LAWHoUj3TY1XYyZAe9
         BZHu9FqZnlI+T6aqrRBWYW3frS0xR7sizTzPqhXxiu2Va3DLcafdsNpt/BtoFnpi9hDW
         Es3DFqCsu2mP3X1g7XO8heqN8SIfuMm5z2Cs2H3zkLJVOegG5Y1U5Py3ncnjHyD/2/Bn
         jicevD8wGB774xbJECFAZPb072daAOkq42lGoIQmSs7kH/V59GCOpr78pvXjsyfD/PuS
         8KW9BpHg04R6q84LIYYf1jJpcDv+oA6V6deMIlI2+Hrjfm6O9TdvxIBX67TXr5YzhOCf
         kfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354845; x=1794959645;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2d8xjP5r+JVIA4NnCjXwCKt2E+WzV1EK+VugnrMgol8=;
        b=2KjaRLBJ8tpyRqYsjTbXd+fYFdki550PNETDZCLorm99CvrCILpQgWi7UZw8ObK5wJ
         YV1fYgsZD4AHLYWO8U2vV/pnW+qx4KnfOWQskBvkWJyplrJK3RHi/g/A90QAmrNmf1Kx
         /8i5EiwfJGcv/Nn9kafk1b2Y889agzX39WX0GldgLLrGpCl+Q0kJvlWJnjfyzGLJoOM7
         xg3qcgvYLs7suQTOxGg3bix6vxQ/eOLdYFBNdDt8VA6YvhC0YOpczzFBAh1EaGZ5iEMD
         2a0EImbPEWlvG7IpiOG6mNczy5BGVFdJyuy7NUlEUyKQiSXcR2Eg1ZdzP6gE8nQ1l3vz
         CUhA==
X-Gm-Message-State: APuU4Z+QZInu3B7u5qUbJHtrFU1WGQjzrRr4AZ62XbSqJahcDCguAnYE
	huzTx4Sn3vK4NknrHYy/rUpCP46Kv/wKy+qHJvAlA6qaXQD36MxLQZyA
X-Gm-Gg: AYBFou1M+7FsY35yu00NME5gKY28VH0AL+e74fCMGLeAr6UJ7Ant1RvSZrZaS/D/AI3
	4uO2SKLzgpvc2hPHg/F+PRZ4p4aLbEF8pdJT+VnTt+rD6FXy65DbII9e13JA8wK3Jwh6JDzW6um
	/jySZgBZHgLcMPhdG1yuji9gsh2K30TpaCtvSelhhB7S+UusNfQxwPGCnH/YU3PkJavFUkPGyyP
	5RKwX4D295HIFNbT06RrgjFMHSpmqYjESGVGIoW3dOQ3L63NpWdT59QSDLxSWw28CVY4TsJeYj0
	muxV5l9GYjf+1x6p96nVSHCtN+MiLDJ1vNdwQm4Rhl2plwwHHCcVOfSaCV+m/Nfahq+zHb9SwAB
	CoDBH0qb5yzCG7kuPir/Nj7IqgSLNhTVgDMljgSahFUpGZBm/uK238iVvCOKbOcF9qvhMIeXAeh
	74/7ATjbsa36LxPR/2Xkh8octphOeTSmFRuTUXe/LiHtVXtmZ6J84vaDKu8CtUI1jn1OQuZI4lo
	lh8FbsPKrQHmQPsVmX73jxKjElXBGQdNgrGB3oJrBaeCBilp59paCVp2kNJLqyF4yzUqS99EYLe
	Nooh4G/kpcGMDke11Gi40HJKRq7nEfwOBsZSbK7BACJ4ihrKhcBx8Hpt
X-Received: by 2002:a05:622a:17ce:b0:536:7220:1d37 with SMTP id d75a77b69052e-556c1774465mr8212881cf.55.1794354845627;
        Tue, 10 Nov 2026 15:54:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555065e4ad7sm36418931cf.0.2026.11.10.15.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 15:54:03 -0800 (PST)
Message-ID: <2e4cd839-47d0-495f-90fe-c5f4a9344bb2@gmail.com>
Date: Tue, 10 Nov 2026 15:54:00 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/4] net: sb1250-mac: ethtool link updates
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Daniel Machon <daniel.machon@microchip.com>, linux-kernel@vger.kernel.org
References: <20261110230300.2769327-1-f.fainelli@gmail.com>
 <179435473107.2168702.11847862148663488665@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179435473107.2168702.11847862148663488665@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 15:52, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by LLM and not proven at runtime). If it was triggered
>     please include the symptoms, like the stack trace or kernel messages.

These issues were all triggered by running ethool and not obtaining what 
was expected: link information, checksum offload indication, auto 
negotiation restart.

> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.

This was tested on a BCM91250E (Sentosa) reference board.
-- 
Florian
