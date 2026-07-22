Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9873E3150
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693466; cv=none; b=hHutcP2b5b9/RAttUS3XpJx0gSJxq6b/ph3r/4lxY/8T3DD+t399sP5Axiqs5nRSuUR27O7RXpYqN7gRJPZQNKEhUQp+avg3R8lmItsDbfU2907mg3vYwQY6JM74ggReVFfZN3m1CPVi+zQibqzCsh1xq9RCbE1kh9svU4uWaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693466; c=relaxed/simple;
	bh=0tclznrSEJ9mothpL+7wlrrUS/OL1uTck8ooNWzuZaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTO3I0J3pB1IIlrI1RIzhAagozWS138B564ijYwQjLKTB0C3cKIxsXsjrQ6VxoUmO3JfoBGkY5XQdxvXeXIPsxzfBwGZ8ViAdaLW8+hiDt/JBuun5kJG3VgWBQvXwIQd42prg7AvVp2RsfM5fz4Pc0qv0nYdDLmf/zyP77EMBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/W0XBOe; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/W0XBOe"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80c5cb9a888so100847747b3.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 21:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784693464; x=1785298264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tclznrSEJ9mothpL+7wlrrUS/OL1uTck8ooNWzuZaM=;
        b=P/W0XBOeoIvE5YMUDqG7GI/X2hSRClFzsS4RQszBItqjVjit4TrYEHm/gxF2XUaMmy
         4jpN5fC2dT5JRMM3XtBEg7CszlSq4/oGXck4zz67tW76m52CLminBerbJqsxuqh0wzHT
         O18tynxolHZnmPJKFYWKV8sJvNJgE0xVyjLx0OSRsFCVSh8UJxGBTMSEdJzkf5UHSLXg
         ya0FnuqU9heDf6pqGdHWNLxC5hDyw3NOFl7ZJgumlkbv3i+HcJh4L0NQ6y1fd9sKgHw3
         0q0s9VfLNF8XOQLutpS293ITbPTnLFnqiS5xte/P0QcQan7vY+AOhDrElARsHsssMCPx
         g/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784693464; x=1785298264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tclznrSEJ9mothpL+7wlrrUS/OL1uTck8ooNWzuZaM=;
        b=Vap73emKds21YOgb7kRu81dlivhPYjVCpbt0HpYQS7I+4EfbfrnFfeik+RVF/6V/TV
         ouaTzfDW1r9r5Hkac7Gf45jlJc/gM9PNQeXBgerfhwJigsUjNgOtC2mx0dr32oEFrSU1
         9+SojDQ5FYQAGFqx1dYgebEa1k518gzZaZNAHnJKAaRR6C6O8BmmWKL/CybuNxQJWX1a
         UxI/3uo4YPNayvUwF/PVvWkVaOH+0jZyd4btBfImYUzZR66NmU/njhJpWonuuuCmeQDf
         UPdoTnVn+dIFxfgP/XlWu6J3iNQtB9LxpVg4rUZdVaPeg7on1gfY+JlkPH5noCzE1DY9
         u3UA==
X-Forwarded-Encrypted: i=1; AHgh+RobsjrSlJOSTfA1JpCotfMvNAF+NTtSb/Hf/JZD1pL4xhGYzp1dUOGstN3sQQAVxE2ANUhEUuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6hllDdDTlS86rmipm5Uhjl1VvpcIKt9Ti2Iz7y40P0YaiOqr
	Nnth/q9HnwJZTxEP0SlHHjw9llj4DmVydp2Zjih8Cg56da6ZT22W0gFl
X-Gm-Gg: AR+sD11cXxi4V0vZN8I3jSgmtCps877ek96GTM33UfRxbESaZXXVdYR4kgMLyQzsb6R
	Hj+DGgx+u2YSKYJrqscQ5YhgJHZG4K1d0k+TbW6sH7jjMEnuW3BgZJtYkuQUtWw4Vv4H9UttADV
	F0N948/Ld4feksP1xHCiOiNnH2rgTGs+v3m1Vm7BNn5UTmddI/pQmbwWR8sg4+hqMSzt0nk5SjU
	DzngxhcNXVFfQEeFRexdHXb+qUWUe5n3GEpr7uyFIIs0GSG5r7eXwiic+F2v+mZsCxCWGr//B0/
	Dc2imALk42P8VUkiXExtA+iGh9eYKVJE0L6+QNZzUPLz++FgbXM7MSs33UAlenxrobRmbU0C4pr
	bkM6V0cF09U1x2XNKpX3hhB0MC+C0N32/csSw6LgSPh5Z/ZklIRzEXL5+MYqOKPxT0FQ5dPMIvP
	pqXQylBd+TZWfZM+tP+TmGCA8t/kLWOx5/gjFebRFh75vAiEjYSWfnU+b0Hj0i54eE2k7LaME4x
	DXMG9Om5jJxrA==
X-Received: by 2002:a05:690c:690f:b0:81d:edf2:dad8 with SMTP id 00721157ae682-81ef26fdd86mr67929787b3.22.1784693464016;
        Tue, 21 Jul 2026 21:11:04 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c6432csm7930537b3.20.2026.07.21.21.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:11:03 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: sdf.kernel@gmail.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net] xsk: reject tx_metadata_len smaller than struct xsk_tx_metadata
Date: Wed, 22 Jul 2026 00:11:03 -0400
Message-ID: <20260722041103.74925-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <al6Czy7Gvhc41RsY@devvm7509.cco0.facebook.com>
References: <al6Czy7Gvhc41RsY@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the suggestion. I've tested the proposed approach and will
send v2 shortly.
