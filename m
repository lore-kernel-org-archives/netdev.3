Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207494;
	b=stNXvJ2sUCXwM4PEED3GZa8drAECAgkRwYBrs/959jjzwQuLGqzcBJOGllgp9F97ODCE
	 sjxq2PGdjJlwC2S8e81kS0sNcukg4PqL8qNHwYl10b3sGopkOWrp963aw40OACkdlNWZX
	 MTUPiDxLhLfw8iIs/0GFneJcKk1B8B5dA3cdH2hD/HyaHcewZCntXJaaEscS69Buniqmy
	 G808XL/9R5iinSIiJ/tOouN/GGZzaGKDySx5k0Cz2jqJON7BgHe9DTk07lsh7nTXaaa0M
	 5KX9KfEc4D+jWeNPBm+Ro0R4m6UmHWj0uMAGz13KZ/vCSr0Tz7BiD8fYg7wZnH/mmaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=+Bj9TlgMdx89QuvYDbkkZB0BkYmkkE60v8E9W6mG4wo=;
	b=W8Wzc/+JFBe730MNw0FHpo0vPySMkZ1HhzH/E4LFPNbnGpzP+ApfhSxJVUMbDmuo34JF
	 6sBky5JT7XyAiLxzqN42+4MLRD3lXC4pUkNafMCgvJcwRRN1S/pfFHPp2pmztAoM/JLj+
	 zo71HD/URZYwFq08ZUQnLmg0thh8yxBfImfkiNcoHFqq3IrAi1Dg1zZOyESrqHLQOU9V9
	 coCmrAoIVfflfSQMbPvlbMZCjVKdxOHoEygiCDp2qNCA+aKXDzV+muhTtF86pIx70gZfV
	 BMy3JqJfzn1rF9tUjulM0WZCo3qI2wzS0m7jRR3BUurQTzoahYC/z7KvE8C3en9tPDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCF6Kdf7;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28878606A32C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28878606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCF6Kdf7
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a121bb8c2so1532025eec.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207493; x=1793812293; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Bj9TlgMdx89QuvYDbkkZB0BkYmkkE60v8E9W6mG4wo=;
        b=yCF6Kdf7jT1vWrSUhvmxbzrJPzT82r4X3xQu0Wo3MziGTaes8IDWLNaHaLqoZVWY9v
         F6REPENUlsKN8TJFDiLwXcarZDvtLI+C7mFIgLuvNZ8pNVX+awq0kC3s8ux/bKs7CCei
         +8ULXgBy4LJmNDtjCwvVxcZ7q9ZhMBq3SixIZEPA+9pYLJGadkFbyBbrd3MWxD/wrvEe
         FeRIzj7ATlRViELe6KEdrDPqHTT1/nE2y5Y7nZVNLe/3OHzSr071tJmuQIBcYT66Gged
         5yqpNcWw+MzyPgAaoGlTfxxndMV5ff69vdOwIPX5ta49X+lGDmKxyxRFRTSzEsp2WNjN
         ihTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207493; x=1793812293;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Bj9TlgMdx89QuvYDbkkZB0BkYmkkE60v8E9W6mG4wo=;
        b=MW/A86N5POj1LuXGpfrHXIKnzE+ExFr2SrSiXCYYyHebbnAYeGbsdMMCFOQUjlptYf
         n3uuF1YkRtUZtDt/CMIo8rkCnP2riedbLrUjgOpHwVWx9ZYX0vTs373rfPRfyYTn+8g7
         Hg2n6a9irm6EREtFJYmX5VW+jG79+E0GAQpQ5dNvxLFZQyGuorDyjNUpoHPgu9wbdW0S
         TsbxXXE9k9hV5ulq4Z3D2dFlq7vvVs70aGbuSG7gQLRCu9qsm//HSGyCOl28XVAK7zvK
         YzyBSjXECTYfsV/iiPKO3UP0k0izS30G3ssrNvS2PJnTR6e3bKo33JEgFLd3oVV9n81I
         mFVw==
X-Forwarded-Encrypted: i=1; AKwUvBzmRlEH9Dlq0hd9Vdtc2NknejkDpttlvWpps0wHhK9hiHGdy/kKEUekiu0PyV5KyDdyh6YUAMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLevhnO2N0/SN0tYw9WmbYP73lhcUxEekIGtwFH/qN4vWIa6+/
	GkOb/LygmzHUWszIjmYHoRSmU6BwpUqUJLg9c16nvty/EjBNiT4Mg4i+IaE/9N+Emf4=
X-Gm-Gg: AYBFou3qt/EZS+kjfy3AaWqE6KB4ilL1BtZNe0ikMkRgQEBcq9rO/gCXuD6+UsgbEwn
	xoYQl0d5i1QTXUqxjc7Lm22qpP2WQ4Dk6EJNRuBJaUpIa2En667K0l3YJ7CavBUz/hOqzijY3rW
	+zZ0qOoYlsUf4njrwIlJhim44afoNttcNM8tDg7aJZ/tuS9YQAxz1dx+oFEzeqSWnt4UU2+ttm/
	57c6hWN3AvDTzQ11Rzlf5Iz5E/HQb7Ma5zxEBtHsk3L/pXmaqXC98QxHZlumERPj7V8Rpb9m3Xq
	hEDMdXDdTt++1qP2ERmC7uHv1WOlq5vBKh3qL+X4rD5zJ8EuIC3Yn2kgR7e5pzvE/L4ionhVmpH
	JDOZ+Qht9z5mUOxfSd2N2GdtJ4c1giOvDOkOZEYIyla6hNIYtPFWKKU9efYQsRjz/12a5QkRLd5
	HHbYO4V0QVQrJttlGoWGpGQWyk+D9IuI/ULUnsgzBMRWbGpRYw2wREwMVa4xyuDRtMgmYb865I4
	y0QO5oTm/zCVKnm4TMTVbs88uUZsKbE7SJfuOHDWPOlkYBYrox00K9AU/gNRA==
X-Received: by 2002:a05:693c:6393:20b0:359:3991:ce1a with SMTP id 5a478bee46e88-36a30051a55mr162933eec.16.1793207492976;
        Wed, 28 Oct 2026 10:11:32 -0700 (PDT)
Received: from [192.168.45.62] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm7789683eec.15.2026.10.28.10.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:11:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:11:32 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring transitions
In-Reply-To: <179320630061.3327.303082876376528510@kernel.org>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
 <179320630061.3327.303082876376528510@kernel.org>
Message-ID: <179320748112.254617.2096305115405815674@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Both issues were raised in Sashiko's review of v1. I had also identified the stale interval ordering during an earlier manual inspection of the CC enable path. I validated both changes under ARM64 QEMU/KVM while preparing the two-patch v2 series.
