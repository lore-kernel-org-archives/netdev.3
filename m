Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267453C0634
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654648; cv=none; b=GzJE++E1iBGfNvxNZ+n/S8UbnP6e11FgAiSAhmpqjgHkVzxa6FQid24/KvEVZo+VpRM6jUu9LuljffQ4PtFJCLIFJe70hl0a9qjrGsxrHKEqChPHGkkOo1HydnxoM9mpIDFmbkecCz2rnl6/St5+0xZNVLxqIQvQQ5q4YUVUK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654648; c=relaxed/simple;
	bh=/nKfeFFOHQD2jfA+Ot1+Vy4o3l3zMms5r5+sWtEZSo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cx79bU4ZFIT3LNDVk+MIaljel5rW97Ki/Xa4hNstGHw8C+Idb7UnbRi+fjWyF9xQMCEuUrb+TU3TrlhzsHySjPcQX2JH/SxB9XjvLk2J09EsoTQ2p0mxc1ltUBzKC4Ajm+V1lXfSUd9vDtREwYbaFjJYDlpDUBdR0tDr93TE4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MI1uxGzl; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI1uxGzl"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13fc403e373so567248c88.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790654646; x=1791259446; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nKfeFFOHQD2jfA+Ot1+Vy4o3l3zMms5r5+sWtEZSo4=;
        b=MI1uxGzlELak7Tfh2eMWrt03/T1Yw+44mzE40RAhFOBFPe6OJDvvIP/8hzQT0rJmV2
         YeXufUt2UIoXqZQ/d4VqIy5GZObWp7f+XwIyDeh6EMbv0I5YtaZdY3c60RlWoH73f2Xi
         Kz+3K/E+Z1AiS1taX2DRUmch36PK4UCZOMz4Q5iOULFyRb2ia4+WUmto1szX44n3M7QD
         CpGnm9+paftsRJjl2CPbIJmMXrzSzCXcPzZUZ4RtC4OJqMLvI9wTJA0pi24XVCa2ktPo
         86ZBo5Q+wPdzCN6dbQB77ziNgYxnqEpxYJ/VqP6+WpR4qn6GKsYyBjj0BsIthb9dNYeR
         itCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654646; x=1791259446;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nKfeFFOHQD2jfA+Ot1+Vy4o3l3zMms5r5+sWtEZSo4=;
        b=HbxiAPrKmbZ9S2tNW5OnB9k+UlR3HTSVLO7C8CBocV1CyCZGY7iXzEahlWEFXp+phl
         9TeTMf8NI7TUSMkyG1oMRZFfegRh/r+MtFkKszSFcbPAWOGkfQMpZWrRpMn21ra03XJk
         jXjol7Ju4a5+BKiiJfDZnVnEjjCIbvs5wpxQapNpX15dIaQDDUoQyNvNnBOaM8Z2f3BM
         dXDVpsqdffmAD2HaKKXRcp2uq7PkdpAe8JwzrHuTN+7uxitObrQXcmnaYLxzT1ebuWpa
         WlnTz0IeB+aIik86TY/2808mCgtSumC47t/PRgtESGJYvwQ7YCkIVMjjxCAy5X2eVY+d
         GTbw==
X-Forwarded-Encrypted: i=1; AKwUvByb2hgoEKt40bbeGCuTF8BVw2zVaSm6kQRxbGOiw5VgbVu5G9gkZKK/c2KcD0QnY92MM5hVDzU=@vger.kernel.org
X-Gm-Message-State: AFuF++lPt6dbul9T8UNQi1/UOpxEnAKIbMIAWNWtWbsljEXFUt+asXuc
	q7YaroRQ8HnAE6PcSfgIEy6W6Uh+ROhYbFR0CLvz1zqo/SuzL0jS2W8GjHzAMkW2
X-Gm-Gg: AYBFou3yiqtaoVWI+hj/O8lQoSDBT1+h1vuVVuUx/S8qen0tQQoWsmqfjiHdXshnpdT
	OzEcafaKMO/MqalssEi/Iyzjmeo6ouZFL/g4/6Ubj7E+qRaq/DdxKjErRAaxCYzI8cs4AXew26Y
	ynB8zejL0/MuqhSWy8+RU6/vyfmOqXdbk1V/C76xiUPxk2o+95fzAKEEzppx+6j8Qc8wqWwMGNe
	WfFZgF5fi9A5/we9m38EE/kafZzKAMxSnQET5jWL2O6mD1T0BPVDW44JXJgoOEq3w+6+IJfJfEl
	Nc6vHZJiO+oQDsyHKBI8t722jCBjPjceVH+mk7oi++xg+atYTbnjM9k6Fll2M+fFF+WiaD/obNN
	lkt3EoiC1XteOvnyu4F7E5THwCGWv7NZJ3k3PZmvLv+AGxvVSMZ23iCEVjWLH5FUCEzULvDSjdL
	179L9920WdDcWFf3RLKoB+k9CjbSo6iuZ/LcndPA3D7O4DcIeBagCgXz32xS8yfaA6C4U1pLtTV
	rl8
X-Received: by 2002:a05:701b:2905:b0:143:1bb1:32ff with SMTP id a92af1059eb24-14b2e52cc5fmr1389059c88.16.1790654645775;
        Mon, 28 Sep 2026 21:04:05 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm20527028c88.9.2026.09.28.21.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:04:05 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: steffen.klassert@secunet.com
Cc: lilly@aronleigh.au, herbert@gondor.apana.org.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 chopps@labn.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net v3] xfrm: iptfs: avoid canceling reorder window drop timer
Date: Tue, 29 Sep 2026 04:03:28 +0000
Message-ID: <179065460863.1915782.14730367973310266066@gmail.com>
In-Reply-To: <apaRiWQn54Pr9hpm@secunet.com>
References:
 <20260824072851.301644-3-lilly@aronleigh.au> <apaRiWQn54Pr9hpm@secunet.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Lilly, thanks for working on this. I need the same timer correction as a
prerequisite for the queued skb device lifetime fix.

While testing the interaction reported by Steffen/Sashiko, I reproduced a
second problem with only skipping the cancellation: a timer armed for a
completed reassembly can retain its old deadline and expire a subsequent
reassembly too early. The runt created reassembly path also needs to arm the
timer.

I have a version which records separate absolute deadlines for reassembly and
the reorder window, arms their shared hrtimer for the earlier deadline, and
expires only state whose own deadline has passed. A regression starts one
reassembly, queues a later reorder entry near its deadline, completes the
first reassembly, and verifies that the reorder entry remains until its own
deadline.

That regression now passes on both the regular KASAN and reference tracker
kernel and an enhanced lockdep and RCU debug kernel, with the queued entry
retained for its full five second interval. The runt created reassembly
regression passes as well.

I am preparing that as patch 1 of a two patch net series, retaining your
reporting credit and links to this patch and the review. If you would prefer =
to
post the corrected timer patch as v4 yourself, please say so and I will base
the device lifetime patch on it instead.
