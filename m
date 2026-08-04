Received: from forward400a.mail.yandex.net (forward400a.mail.yandex.net [178.154.239.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7741D20C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828337; cv=none; b=H+Qn8MpAYnOWSXru2K4r5AgIY0ZbmUOPR4xneoy8VF9cgUovurHNKaXLyR9ujDgG7NgiPlSgowBoxCZ0JSwCtUJx/cOdsyr8eugRSA/l7h6FjrCwH+eR5mUKzt6GW8VXdRKDY2QKwbGQJt5+dIX8cv63T07IwM3SRvWXTiCAIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828337; c=relaxed/simple;
	bh=scaG4pog9nIGdfRvtCKenhZHfsqxJUX8fPqkg9/7oZQ=;
	h=MIME-Version:From:To:Cc:Subject:Message-ID:Date:Content-Type; b=LZpdefqxszS6bnv7Vv0jYSmEcTtBsmaHzKjU8i3u3ePhSkxU0FkgwSXU62jHIybjKBjwcuKlWt8NtTprrzHR3tSKEphxglqC35o1GrBPt7+auN1oWx6qhXXr7fS3D4kmqkOJK6/nqgHiioOasz5aa58t80X3p09qfrpyK88C41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=woralelandia.com; spf=pass smtp.mailfrom=woralelandia.com; dkim=temperror (0-bit key) header.d=woralelandia.com header.i=@woralelandia.com header.b=aQKKx+vf; arc=none smtp.client-ip=178.154.239.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=woralelandia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=woralelandia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=woralelandia.com header.i=@woralelandia.com header.b="aQKKx+vf"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8c92:0:640:e75e:0])
	by forward400a.mail.yandex.net (postfix) with ESMTPS id 00F48C21D4;
	Tue, 04 Aug 2026 10:18:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id KIe5nflfSuQ0-cyfEDhkj;
	Tue, 04 Aug 2026 10:18:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woralelandia.com;
	s=mail; t=1785827903;
	bh=scaG4pog9nIGdfRvtCKenhZHfsqxJUX8fPqkg9/7oZQ=;
	h=Date:Message-ID:Subject:To:From:Cc;
	b=aQKKx+vfxwLHxUhdxzgc9i3qTs67HLG28tdvT4arMEZEUAVREZdOEF2oCKZpFYVe6
	 v8qxH84l2WI7/KK44B2fJn5W6RLX1uCJ3gF7TGcObj0oaMgWP40QKkpF7JvBaVtQnO
	 X02yUFQMHMPQtI3Ychzf6mXW9kiYA+fW9h6GLfW8=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@woralelandia.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "=?utf-8?B?UsOpbmljaCBCb24gxIZpcmnEhw==?=" <renich@woralelandia.com>
To: <netdev@vger.kernel.org>
Cc: <hramamurthy@google.com>
Subject: [PATCH net/gve] gve: fix early boot deadlock between rtnl_lock and service_task_mutex
Message-ID: <18c88903de19db1f.df50d089680ca23.c305d6e51002e357@desktop.casa.g02.org>
Date: Tue, 4 Aug 2026 07:18:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Netdev Team,

We hit a reproducible hard deadlock (AB-BA circular lock inversion) during e=
arly boot on EL10 / RHEL 10 kernels when running Google Cloud Platform VMs w=
ith the gve driver:

1. Thread A (NetworkManager): Holds rtnl_lock during __dev_open -> gve_open =
-> gve_queues_start -> gve_add_napi, and attempts to acquire service_task_mu=
tex.
2. Thread B (gve_service_task worker): Holds service_task_mutex, and calls r=
eset recovery which attempts to acquire rtnl_lock.

Serial Console Trace:
"INFO: task NetworkManager:856 is blocked on a mutex likely owned by task Ne=
tworkManager:856" at RIP: copy_net_ns+0x1a4 / selinux_netlbl_sk_security_fre=
e.

- Working Kernels: 6.12.0-246.el10 and 6.12.0-233.el10.
- GitHub Issue #93: https://github.com/GoogleCloudPlatform/compute-virtual-e=
thernet-linux/issues/93
- Proposed PR #95: https://github.com/GoogleCloudPlatform/compute-virtual-et=
hernet-linux/pull/95

Best regards,

R=C3=A9nich Bon =C4=86iri=C4=87
Principal Infrastructure Architect
renich@woralelandia.com | renich@evalinux.com
