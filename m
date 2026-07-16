Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2442FCA1
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212741; cv=none; b=Jk5aeli063P889efvl4RKRCaJ0okc71i2ksoFjX4PJ04BbNFsDQlGjCRgry43meaTtgkzcEEN2Bv/vT2rx89kbP51fNkoRwZ77QRXBFijhwvHhXpQEnV6YxMo685VdcWxZ4CzHJZvQZyiBgC8V35J1MVoWb0+4zDF0Maf8h57IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212741; c=relaxed/simple;
	bh=+DWWycF2Ya8d3r+BKSyQrkBt7+k+gkI6OHJ9lujz8L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gSyGIFsQD6mzQxQh48gucv/iFMo88o6APnd3RJHlZkwg99P5a/p89Z6URydCe1/PlTSw4K8y5AaWZKPvrTIXVMVrS8Dtdit9sAbxKRhwf+FQkgLlI0sIWYc3IygMiTY3x+SrXXv0NzK5UFknHy7pkaO1Ch1Afupc2PHzjgQx4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5B1YV1R; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5B1YV1R"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49253e951cdso2835435e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212738; x=1784817538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DWWycF2Ya8d3r+BKSyQrkBt7+k+gkI6OHJ9lujz8L4=;
        b=j5B1YV1RgH9ixe1VssNaQ1dEY7aVhqb+Rf5HrO53MtXa66YQD23Qflo4AQ6/BYwmTR
         qI6AN8DbnfmE/70PiGCpot8iLqk/oqMR5h2+nMH6+tA5zY5Z8OQoIKDaZuOS3cW898uh
         FauUM8CFCncUBZcYZX4rm/J42Hpp0UFmAAwHSZHf92DqEyCfVDI7Nf5+fJKe7gO09qzv
         O9XDBrwlr3DS455dqK4fgVNS7PIPbnOlYhT5umVE99ey1venB/MpgLtqycNt2ZKIW2X4
         JPp03JZEbkaEd79izonNpkY8SALKJfvOYVa76UPy845/Jj9c41NcQVwWYenUHV3CKeFb
         xjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212738; x=1784817538;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DWWycF2Ya8d3r+BKSyQrkBt7+k+gkI6OHJ9lujz8L4=;
        b=lHAWkuwYa5Z1UKWzSa4gHbqjFvg/vG79+RmLl51szI3Ee2fTBo69Nqgl8mW/EMhh2O
         MIMG6bzIcjsnFD+/1o5D3jslOg69k+Pwfce7IUnE+NVqg2d4VG8H95+XO5hUM5XGnmIv
         h/KZkSqj/fkK0HkTSJCqSRxndv9sufMbqWDS3M1bU18lWm64AoIAHLXoZgGdnPHCuAlo
         l7bCVKlmX2rvq8PX0iGlcernSaiXKMv/uXwsA8q3YTT4bYVSiIVSyb1wqlw3mlIxfnU8
         g4S8InU4/vL5mwPNX3L7d3+Cf+U8JsPQTxaXLCZOK/W4VCw7o2HAybjcIV6r6tfyQ67I
         HEZw==
X-Gm-Message-State: AOJu0YwjtBs7MDP8NUNXw6QFbCJXdNwmQ12w/aKqgRzcesWgXa2Djj90
	Ut/COCf9AYGZJ4DP6rdd9jOoSSg4fZRJHGZBU/HQiQ2WFE2xEO/BePf7
X-Gm-Gg: AfdE7cmaz5smjK6KOP95zvZbLamLfoc7OhUPI5kT5cy4dG54Yvx/MmnH2aVtybWr7JR
	wcn8WeRDJ3STzZbyh6vNUP557hKZvNmFq2H8ZDmibx8mMvwYSaZX5Xs9VaX8N0UsqLhHdrFIL7S
	P/F+kQb3da76AIzzHWaf19qsNMKLRvtgQ6pjY+uN0kyLSDTWYaVrlONADk+r3tVlDpACmk7J8QG
	SFskxV/DHHyGaGxbsJxh1GIYtyIVuIiFN48POjQk6ipYDy7T96Ja7MZUeseerMshspdNlQSJ58z
	DId3MMEY8QBqpGhvabz3WRoGn9hyPMr112R1KV4xGb4Dlp7BpeOu5Qd4bu0C9kk4UCh1QH2WGxK
	C/28CkZWtdfMRxIVDURDGXwa5HVoP2g8cZpRX4GaoqC9W8qLIuuEL6vbVAox9jw7sLsC2Oy0vPS
	jfP58zDOxztWYR8smyDXdtzlALK8aU9RfUkrwV3edQZ4B+VUTRq1gPA6N7OxRaFWmGOZWISss/K
	3DEqmHEiXM50CvI3lngD7FltVYp6okFVtOZ8bU=
X-Received: by 2002:a05:600c:a214:b0:495:3ca5:7069 with SMTP id 5b1f17b1804b1-4953ca572d6mr36272755e9.6.1784212737534;
        Thu, 16 Jul 2026 07:38:57 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-187-169-051.77.187.pool.telefonica.de. [77.187.169.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c599049sm102981625e9.0.2026.07.16.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:38:56 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Felix Maurer <fmaurer@redhat.com>, Luka Gejak <luka.gejak@linux.dev>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: hsr: add PRP interlink (RedBox)
 datapath and duplicate discard
In-Reply-To: <178420323080.16062.7813915035618214520.b4-review@b4>
References: <20260706134131.61659-2-xiexinet@gmail.com>
 <178420323080.16062.7813915035618214520.b4-review@b4>
Date: Thu, 16 Jul 2026 14:38:55 +0000
Message-ID: <178421273548.70.9896722161695038010@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 14:00:30 +0200, Fernando Fernandez Mancera wrote:
> Since we already have rx (enum hsr_port_type) here, can we pass this
> directly to prp_is_lan_dup() function instead of passing frame?
>
> Of course these calls will need to pass rx too.

Yes, that is cleaner. Will change it in v4.

Thanks for the review!

Xin
