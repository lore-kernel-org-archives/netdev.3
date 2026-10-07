Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB103803DB
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791348932; cv=none; b=dpmrfFWYl93O/r/PKZHksGB4h6/qJdlb/ZUmtt7UetJKPk6F4dK4TgYF3yt+Q898vvMIjxOTkIO9Dl88scekdA63vmqOQKfR/fHba2WjB/R2oCqTrHlRWungeflzlXS0hbeVmuEDFJ2iyaJbiikaUMVLsI0KKTDBu2K1n2jhb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791348932; c=relaxed/simple;
	bh=Nhv3V2PEZv9DaIywRXpuQSuo3SZq1+RM/crAjovCZI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujDpEwKrr89zVuZSk44yWWzwdwtsxTvyxQawi3q55clFpVciwtkDCZ9LFzl2tcPzboKHhcHW48MbZIOeC+LewPvQy9ygZ5WqaXsdtWS/hhEa6kBdQpIKt916hDVh/abRc/fx7TdrFSmfClcf13bpA/hEfpRy7FeZabejqgr4Z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nv1p8xdO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv1p8xdO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48870973bddso840818f8f.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 21:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791348929; x=1791953729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3BMYKHdF12goXCIRPvU4kuoDtK1ZjXLgJnPKF5B85U=;
        b=nv1p8xdOrJSa+fS4UFEPMKCZObdcb3VEA4/dpjO8cn+D/m1KHvU9dk6/9GtrymYrr2
         oYrncpqYUTMy//jC9et2PLN+bNT5GgGtUvogFSZsMBZ9ygumJEUOTOKUOO4skQN/lanA
         Q1n88xUpUJXPx9GICSvP8EUpE9twC48OJBBUlj1zqAx/Iwzvz/wmVVKY7nhz0f+XYnA7
         SLK7/kNjOnYkWhoSWoV/lMGqnzYQ0Pf6Onmc3qT7rBKqMJ+XqxrQXXXMtg6+xUrwU9Td
         kRCaqenkx+DI44JFC/VO5MT/mU3GLWnUQpoRNJ94JKDdHjtx/sdN9CIO6+TfqdBO8TDV
         8i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791348929; x=1791953729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3BMYKHdF12goXCIRPvU4kuoDtK1ZjXLgJnPKF5B85U=;
        b=IHpEWud/UbwdvMBgKI1NZ9rCmHJjEOdP70GZHapLfyNPdoyedpTmuvvSL464Ft7zIC
         xEpwj5JcQb7fdOQj8ORo/ycpK0x23N++Bv/Bmmzfhsd68eOb7OWFq9Sd6dk4f69XKR43
         8BXjB/vOcb9OAv2h3DS7s9W8dBBXqX9q6ZcnXxPvQrzs50JnFg9J+xnZ2gqFbjBOgckk
         7MtIVCn1XGqqHaLet8G3zEm3Gk3m9ddSI/rR/xkoGhPMkc7X6uq/WfyExzfBONbVaWWy
         aX5gXz8bXRFRjfpSW0oNLdS7q2sJEE2h7o3z80U41Oh8Zi1YnF2dxiltoQ2/F9ZwyiuF
         nbxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwG23IjRkCMOWnHNbxr/I0Ol18CocnMHNTOkazJW9unq48CiLO0q1dmMo7ShM20cY5cAJUgWbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJjnn13JACT0WD4CxEKpJiTCj4hDL0r+AmS49vKSdhgic9Pf3C
	uE9tN3ATUTTt44nKFYi0Jo/0/d9sIC4xgShGseBnwHBLq+eSaKnaB+ytn6qkrUL2Wk0=
X-Gm-Gg: AYBFou3w75ZDgyQeUeJGK6BgJ+7ClHghoHVCTy6oOoygR0K+7URfR7lYxEyF2k3h9R7
	q90LR+qz1fYyhLWUYYetWYftbtZsZmzdRbZiM0ReIbnxNMfj8vE50IkDPmgl6QGsWUqykQSjgG8
	sQYc2nxA8w9bHSNRwCQ2ohEifC5/a92VPLnY8vFt5D8r7qb+QcR2SN1cR4psPRLmHqB2VDkiBYM
	zOZ1cfOiKN6LLqNtyLLs3eVdUZezdyRG6o62ttrSi/i693d8FRZlSzwajJHn79suF75vlB7uWzu
	xAC4pY+QUwVbXBUh+hdcGl8ursnoPr6g46fPXKc35+5Nq0M6ZCckj5vanBh7k66KIACGIIdVVJJ
	1pkDpju5pSa0me/HinzmRAlf/j+b/+bc4ctKyzDIco/t3qa9uU9gKeobO51oR+ZZSL1O+xTgrZ5
	q+2Mdhi0ciQ1nAw+MVrjAziUrBE2teznZYlArGA3sgiIgwAqZ/vsz/KsYHi3KOuSA=
X-Received: by 2002:a5d:658c:0:b0:48c:4a62:9b31 with SMTP id ffacd0b85a97d-48c72749bbemr1719860f8f.5.1791348929426;
        Tue, 06 Oct 2026 21:55:29 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c75b56537sm888360f8f.59.2026.10.06.21.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 21:55:28 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: pabeni@redhat.com,
	netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/6] vxlan: vnifilter: bound a single request and account per-VNI memory
Date: Wed,  7 Oct 2026 07:54:34 +0300
Message-ID: <20261007045434.499651-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7913b40f-f7d2-41ec-acb2-1edc7f2b833c@redhat.com>
References: <7913b40f-f7d2-41ec-acb2-1edc7f2b833c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/1/26 13:45, Paolo Abeni wrote:
> Sashiko complain WRT partial accounting of patch 5/6 looks legit.

Agreed. A VNI that carries a remote also creates an FDB entry, an rdst
and a per-CPU dst cache, none of them accounted. v4 accounts those
allocations on the vnifilter path, passing gfp down rather than flipping
the shared helper, so the learning path keeps plain GFP_ATOMIC.

> Also it would make sense to reword a bit the commit message of patch 1 and
> 2 to reflect the above.

Will do.

v4 will also bound the dump per nlmsg rather than per entry, per
Sashiko's note on patch 4: a device holding 8192 contiguous VNIs can
still dump as one message that replay refuses.

On the Fixes: tag asked for on patch 2 -- Jakub asked for net-next
without one, so I am not adding it:

  https://lore.kernel.org/netdev/20260921150904.65a704eb@kernel.org/

pw-bot: cr
