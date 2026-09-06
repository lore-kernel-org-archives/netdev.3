Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903E1E5B63
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788684955; cv=none; b=G4CnGUp5FKe1EMKsY+peargVEqvmEa3Hes2cgJlAl+nDBL9S1tGbGgKzJ1PstDl/LYixgVUfxQ5Kaf4ib8S1o/XRHNf8QBz2U1EZogqx4on9Hx5BZ8X99RS33/8/BjYVYx1A1cc6nJWUishOuJuzQK6VR1kJYwCuKuGEi0hjfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788684955; c=relaxed/simple;
	bh=0fTfsL6DtqmPMUydqpBYd80XQl/Qn20sllWNzRzTvMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbO68iOTsF94k8ClqDwR3cau2jVbPifZq5fraCk4Hy+BNB9xv0BH8eX5KdlNFHSz9JqooGyya8wFp/cx/rtJDHPyxw46PzdCEk+JmdVwMCt+EgZuEha3V0xDmG8o3jSIHSliIOm76HA7ZxXbk18ugxuRyIiDmtGhY9vnCtC6xOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dll/oKXf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dll/oKXf"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so175764685a.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788684953; x=1789289753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mnNNWacIPNZ19BAK9ep0Ao6WbM9le6D+0v/1tBsMak=;
        b=Dll/oKXfI8V5JlPIOU1Z+gl6+BXWDPO3GezhvE/ojPxdxymbn9qU6P6mnaXxSrmgmD
         YFN8xVdWTy7T8MXtPO1CjnVmBopXlksVXRLoOVqLbS+PQaGimHYzOzDlVdmRrHVsAAV2
         vTS+GKnI05CqmkLuwvZwm6ON0iPEw2zp+Uv69U5JI2Vh1xgeaRJX/dEfHiPJWnvLndr/
         +nMVMrarrvQ9AR+aDiO3+0R1qDPMWQct9QdAuqKxBrqMNZiOfZ0lH0fZyz/wXbA7sH/y
         JDEexVoVBkdeBRkueY5jEcT9+zMTd2cdPMmai1nUzuHQGsVc3ZAPR9ZeNGCyK5t3wmO0
         1yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788684953; x=1789289753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4mnNNWacIPNZ19BAK9ep0Ao6WbM9le6D+0v/1tBsMak=;
        b=A82sIgW/+m1pN0YKn7f4Os3oJNvuOltFwbLF34lnBEHCoRFqpw9pdXeq8cdGFSdI/u
         vttiCwuWs38qeJTmiEkwgigNuqijr5UPo/SDNpLfcVdE1IOYj/wonDfX/B4aKOAJCVmt
         k2dNDPAihOVAZV+SowcMLIxyJORW9qBM05dovqlc9z9QxaYXKKRTq5gLpDkLduq645Xa
         oIUiAzIOqHi14QdwbcSVACjOsrpznU6G428xDZ+Hun/Dx6ktmhsKlA1wSAinV+cqMQd4
         MJ/rh7b8ICh0e9D1ZzEsxUG00RrYlYy+o0v+1i5ZJumi81Td1Cpy8u+zNKu31qx73YzR
         HfjA==
X-Gm-Message-State: AFuF++kUhvqAhnDfXbB/1ghEc0GQWlzQCiCoXnMO00+O4FVw/3kvgGNq
	8UNnPsLLLLZrwZzaiigJDFCQ1/qyHI9bDRqLoYykL6aA4a+UBdy2WhOPG3wmeCMqjvQ=
X-Gm-Gg: AYBFou05jHBjaZn6Mz3WKYdJDYB4hpaGemWMkQgRDNHxEHRmOtA+DRcHh0PwxdS7PfY
	nGM/x3qqtds/n5lxVibd83GTMeJIXKemFjbg1YVWfhTgiIs73KoBKczCpVYlWCGfa8VLp/LUoZM
	0N+bUOpW75H0P9RpeUvywsFsK3jAfWAB7sX4vQOqO1Ct1K9Y1Sg+OAiO7wE0KkMCg9LEgz8Ckdt
	AgaLgBj1s6z0tnQoo4PiVaaWY9xB2ZknY5VZp/KAuoIyy3wbp7atqAMj4x8VC87t4x/+1u4qL55
	HmIyPJ5/oMOPi40824HIEN6tDVu2OrOMIEyhgLpXLnn982n5SESODJyHO0ulhBj7ZdmTjBlA8pO
	670HLMNiJocUACOdFtrYX5DX6ZNMSKi1xGREnowfoQhb2TCKDymYzXevPGi6p6dfWCsVW0jculx
	uBnuBnxvprnF7K2VYITWoyNv7vNNpM8lYQsGBX8bf+fFAyJ5ApOt/aYKwtOHunm3g=
X-Received: by 2002:a05:620a:4622:b0:939:9e38:5d with SMTP id af79cd13be357-9399e381a2amr424103985a.1.1788684952605;
        Sun, 06 Sep 2026 01:55:52 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939a57535a1sm56087385a.0.2026.09.06.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 01:55:52 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudron@redhat.com,
	i.maximets@redhat.com,
	dev@openvswitch.org
Subject: Re: [PATCH net-next 0/4] selftests: openvswitch: pylint cleanup of ovs-dpctl.py
Date: Sun,  6 Sep 2026 04:55:40 -0400
Message-ID: <20260906085540.609993-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905104026.3776396-1-houminxi@gmail.com>
References: <20260905104026.3776396-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series is a respin of the pylint cleanup I posted in May [1],
which got a changes-requested. I forgot to tag it as v2, sorry for
the confusion.

Changes since v1:

- Dropped the patch that renamed the NLA classes to snake_case. Those
  names mirror the kernel-side netlink attribute enums, so keeping
  them as-is makes the mapping obvious and avoids a large
  cosmetic-only diff.
- Rebased onto current net-next (base-commit 9eab111e7657).
- Pylint score is now 9.93/10 (upstream file scores 7.66/10).

On the direction Aaron raised in the v1 thread: moving ovs-dpctl.py
from pyroute2 to the in-tree YNL specs is still the right move, and
the gaps I listed back then (no ovs_packet.yaml or conntrack specs,
datapath flow operations and attributes missing from the family spec)
still stand. This cleanup is complementary to that migration: it
clears the mechanical noise now and shrinks the diff any future YNL
rewrite has to carry. Happy to pick up the migration discussion
separately, offline works for me.

[1] https://lore.kernel.org/netdev/20260513121240.2590767-1-houminxi@gmail.com/

Thanks,
Minxi
