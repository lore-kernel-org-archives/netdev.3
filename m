Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E52242D67
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110681; cv=none; b=NrWbK7OJn3lcv/QCtLCGvOGscO/ESGFsfxdI5MeJeBNdGHJACJZN6vyHEKiw2O2qsOViGnK7Y1IKWAbxi3OJJnOVsjlzYNdXMgIBPSV7b4IZElPia6Fw3AB0Ei3xR2lbdC7EGVIwTlBuMCPdhbfyHdDtv6xZhYnA05wr6BEBnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110681; c=relaxed/simple;
	bh=pPpVYZE37MEdXM4A+LvUAcPCWE74zNQfH8gS2u8rINM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=bpEEYbLQguPXHnFKr6NhUFROqFmZPUEndXYYDoy6O7fRKlAveyW21l2pO5xXekQVuFnu6p6IsO2iEyZvL2JB9eQ1a6mTLY/kjDb1iuG6Pu8W5bLVK9WWJ6QwmpnehA6PV0rx06ROYhOscdaaUDvBkPK9gGdLgrnsRzrpaig8Ybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA54Ps/7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA54Ps/7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89d6bd67045so314027b3a.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792110680; x=1792715480; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pPpVYZE37MEdXM4A+LvUAcPCWE74zNQfH8gS2u8rINM=;
        b=dA54Ps/7pR0FU9wNDr9tY3+FpNTxC29Ck0g7Lx9551UcjbWRuergvCfYwqHsLcci0k
         psV0muIX38K/9zdQFoVCKZE1QuBHSNFSNJcHGrfhYSkHKdbgpAR/k+6dEMK4jXpl6CeR
         dfOsI3iMB0v9G3k+hGqStjHifMQklrv5V3tG7rT6Pbl9WQl5Nd747zoKFCwZvskD8vcx
         By3uujNiVzEnkZnMcewEvCnuM9nwy5SvP8+Z2Yr+/OE+OmmWeJ89NDzyy7U4r8Y25AKT
         3UJ8/pWZLrLw6U69XeNrydWYhGkvQHY9JPqNx6eNd5x+xdTMs/o2QPCc8f1Z/n9d8dHN
         PmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110680; x=1792715480;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPpVYZE37MEdXM4A+LvUAcPCWE74zNQfH8gS2u8rINM=;
        b=xUIoK6qv9uPG5NCwf6gnhIe6HdInidWI6MyTM/aP680HtdeS0HS+ftzaJfYpm4LRYq
         iUC2JmBpCKCuggKiGWE+mDTaM1SrSqHHt/D0ON/m0dt8IX+W1OSWSy5Xu0IW0D8H+pWD
         7+dJbbx15++jxNpEznKxZUn8XCoIu4vJPCnNDOtPiNpMPXHKqF69aX84gbbtC1OuvOR6
         bzPl9qudsIQmjbviNmTZB9UajeB6Ll/iY6Izs4XkAdE5QFOViRH2rkvTpxQNTDdH0cso
         lsah7tKb8g5DN87A4Eo4ArCXegEcoJ52P1fUhPD8tByKMdCbg1DHoQ32Uf4hMDoyotPP
         xpKw==
X-Forwarded-Encrypted: i=1; AKwUvBy0bBmp8cDgsHuURU06wcOZ11vDIPdHV/X6FZ9HTYVeqyK+eZJD8xk6HRCg0CxdA9RPWPcl7bQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmtpxCl7Tu2Hi6mk9IkwX8FZU2lOgkJ2jn9zrrvcT3c/3PxNvQ
	J3/fe5MnZf7l0EBWI5YsBP2cvnKtqwCYGoP9z2yAnK2fcaVnKfyhJO5S
X-Gm-Gg: AYBFou303eq7Ltm9S2tSYxr5BYVhnM1oRqzVQ9DLziWRM2Pg8+v3gUlIa8Jak50nS/2
	xul5nKsUgI/ZVLh4d/gCdSsW/EzCHfdeMBv38B11dx83spErwYkqZmUpQuj91OOA8OQHh2fHNTC
	S9xijWYoqpmrkPOV+NR2SGAGteAqVVB5rXmVtmI/UDLp4NlEW5FHrzuUqV5h+OnJoIWOgdaGyM9
	Mn19d5UIxwG8HpJCoeqWgoBYuUFuK17QqrDeNEgQyugmFLkXUfGoUqILF+4pKZDg8ilqzKE/wYp
	Z53R+lG6tI9H4nskHbQJgJcrKSLac9bx9w/5WJqsBuPJvq1PxpTzwykwIxyNymF8xrDGprHFrQ8
	z/zhip91cZdgU80b4qLg9U3MvzBcxzvwEi+l3Re6Gm1nOUzTeH0HdaWEbmPQ1LV2JmxZDb+8pYd
	fpEyN6TNrruugF6I0rxg9Oq7COHoc/CRehAfTs9ry/kyoClge1JuqqgvkByisJt0kKcGk8dT6ms
	C9co+ElBbNOCgyEzjhAqMSSGeZmgMYb0cgiPzp3pYC/+V3RO/AY62aDCYoedN20b6UIVVCBfbZY
	2KQ=
X-Received: by 2002:a05:6a00:230c:b0:877:ce59:bd6 with SMTP id d2e1a72fcca58-89f1e9a1c35mr1115329b3a.1.1792110679891;
        Thu, 15 Oct 2026 17:31:19 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947a64sm275547b3a.41.2026.10.15.17.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:31:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 00:31:18 +0000
Message-Id: <DM5U7S0WO4CB.72E73EAOUSGZ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>,
 <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <kuniyu@google.com>, <willemb@google.com>,
 <shuah@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 0/2] bpf: Fix iterator link update target validation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jan-Gerd Tenberge" <janten@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261008161309.8179-1-janten@gmail.com>
References: <20261008161309.8179-1-janten@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 06:13 PM Jan-Gerd Tenberge <janten@gmail.com> wrote:
> Runtime testing in disposable QEMU guests confirmed that the resulting
> out-of-bounds access can reach kernel-owned metadata of a separately
> allocated live map and cause a deterministic kernel panic. Corrupting a

Way too long.
The prog needs CAP_BPF and CAP_PERFMON and it writes past the end
of the map value. That's all that needs to be said.
See "Length" and "Impact Evaluation" in
Documentation/process/security-bugs.rst.
Trim the commit log of patch 1 as well.

pw-bot: cr
