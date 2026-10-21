Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598195;
	b=rREZzAMpmfJ+W3nChIXm0wxYEcQa0VbSjDMMn/Wel4+1dGlrkfJOQGTpm3T5kjdMViZH
	 HUqGh2zqcQPlA9RFyQn/vnm64Fz8tB4KZAfZot+8jAjIwyKS78n+EK0PlYzkx0W3ZTEfY
	 ZlzDlICof+/OWPQ/OUBF9/1GUX1YqDbaL6CIVBZ4QQWc2m/MnnaQn7XEXcTdKSxcVHOUG
	 kumoPsjV2UCyJFpXs0lapC+8rFMp5DvhT7/YoEZQ2Ra1qhwaG1RACyWjYKZEINX77zJP8
	 Vaw7ZHYYmaOMZAB2hXI4NjwYsYzDI288QVNvjw+2cUQUpHQ5SuqHBaU+R51sLxhr6pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FCnhV+lw46CyFDBN1UCX/mRnoUsaQyKF8bIYd93ewTk=;
	b=2Fm5b30J2+g933QXBp7UtcN+GzI4SapiaF8QUZ9Vdo60zAoF8ZmCmRG83Av8medqgkc5
	 FvL7K0Sofmkk8dvcR3KdJSV2FO7rnzFk/SoSi+oQGi5rgin+hCeEdGFjvoVlwcTKiR+Vj
	 Rl7prAS48V7IuN6HxovgVxUxLuEzcjbMEfuWoAOfihxMvan87Z1GVEy/1wqYI269W5Flp
	 0Q8BLhclfOyedxUIETf8vtI9GMuUXFvJGkK5sYnAuNN93+FayBo4JWSzFTvLHHyf5pIAj
	 xWVmLYeoJNcBrTJ/AHkEXjIK89Fpv59aKlHBvh5VSGB+zZvm34sJ7x6HSWIwUJaIykg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GrsZ2rDA;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588BE606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 588BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GrsZ2rDA
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso447929a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598195; x=1793202995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCnhV+lw46CyFDBN1UCX/mRnoUsaQyKF8bIYd93ewTk=;
        b=GrsZ2rDAGG0a0xgUAdwsNd41lp8UzTekV9p0VDqvOX9F0jLmUngcbCWBHVjXYazPwn
         BQtb3EHlwT47Vm5U/87fY62g07CqW9losqZzvjv78F0dYqX+95LsRv8qC5k/+GDtfCMF
         m4ZZmcWC/ukv4rkDZ8qgzSgyLDV4vzTq24He7LxfhUBgsvj4/P0kURtVvG0rjIDnn4ep
         84wu6387KnKZjYh642JQeT8N4km8ujQo0ZxdIQewLOFGZTiMYSAyZwcBvW8dFFURjMyX
         Z8erMmNi0s005H+cpppAESbIXGtBIzo1Oyrz1VXppyYYT49Up/wnsPDtgiQGnNxtFGXJ
         cC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598195; x=1793202995;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FCnhV+lw46CyFDBN1UCX/mRnoUsaQyKF8bIYd93ewTk=;
        b=woqY+u99nyWJ6ZE+9AnhxLuz28R5uHZ0DNl7+gyuuPFpkBtUvPl4KDfrvGELddGc8I
         avLduFMo4jvKq6T8g+lga/l2bilLugHv2EXEddbN5XW0N0jzCMNdbGzp3nSyxyQROVFt
         OlkNl3ahiF4mHbBSRi/eG+ZyyKY3RW860Zbc+HehgivnYZCvF94YgciMOYzonZRF9Q7f
         L5f9fiQi0ecQq/Swniv41XAWqJy752oVDZzCY+fs48T5EFDDTRxJ4GpBNMxoKG/Itl9t
         6BXVDSGFGV7ZXh7874U2etOy7j5o8Zh32b3lpec7cToYVAUPoUOeO5ex8R8Ep9P54YIw
         mwvw==
X-Gm-Message-State: AFq9FYI1xoxuGew7Qwmf7CB2gyVUIqPUDgEweh3NhqV2UMX7Wg9/QCjE
	wedi2biOlpEJmlywb+GsA8ZpuNuzKnDral2S8W9b4ZKIB5ic75pLrs/A
X-Gm-Gg: AYBFou2MrlsKXSX/VqktTYrcoO8X+07qecmS2F0T0rierplTdR+AtO1+oRWwfM+a7WX
	eaVsZoevUWzJB/omBpke8hzdGW0N615w5N3M590KIpVuxwIS1HwsGlR7eoJAIMYZv1OifkcU8U0
	bnddd5/kDoRs614QN0ok9KLyDIaenWjZN7lVpzyeKknzns6x8f1gIfzPZLoJOjR5yN/4eAFzMgX
	5Du1v8bfDBLXDFvESRsSNdQnwG5UxQRuD0lYgTbCn0E6/Q/AvIb8v9fWX8aGPx12wLS5HndLOU7
	20Trn/EFhOY/KAAkNeAnmw3bAyadHv5ZJfI05DTycfHOwarrIiwkoDDtKPJRvmcaCUGLqNJU4WX
	guHGSNkBqI1GdSpSk2irzrVxEDDgXfvMi9s8pyKUKABCwbX+QeCzZtrCNp2e3s3onylvxkvZ0OD
	71Um5JlBmV3CF15sF8T3Zc08XGhUE6c1ef/b2t6H5sOxlZ3UiK3Lc99OsR3tx29/B9fIvnVfokp
	BNCH9GxlWOZtVNkCDJX7sp/vZmk3sav5sgyIytbG3FDr8oSO6gpc/z55rQ2Ei+zMHi0ExmuFIal
	FszmlcKMh/RViCgijKuAEkYMxBhT1yapX9Iz3Y2NmSQt5LWyqeMftbtoOR4=
X-Received: by 2002:a17:902:ce86:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2ea43e179f9mr19372535ad.33.1792598194718;
        Wed, 21 Oct 2026 08:56:34 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4536ddsm13394895ad.43.2026.10.21.08.56.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:56:34 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for saved_data_ready in the verdict path
Date: Wed, 21 Oct 2026 23:56:29 +0800
Message-Id: <20261021155629.68813-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sk_psock_start_verdict() and sk_psock_stop_verdict() access
psock->saved_data_ready with plain loads and stores, while the sibling
sk_psock_stop_strp() uses WRITE_ONCE for the same field.  sock_map_link()
/ sock_map_unref() touch the same psock from another CPU without the
lock, so KCSAN reports the race:

  BUG: KCSAN: data-race in sock_map_link / sock_map_unref
  BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref

Use READ_ONCE() for the reads and WRITE_ONCE() for the writes, matching
the strp sibling.

Fixes: 2ef2b20cf4e0 ("net: annotate data-races around sk->sk_{data_ready,write_space}")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KCSAN); it
reported the race.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
CAP_BPF / the ability to update sockmap and attach verdict programs.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/skmsg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..0bfb8c4e7f36 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1260,10 +1260,10 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 {
-	if (psock->saved_data_ready)
+	if (READ_ONCE(psock->saved_data_ready))
 		return;
 
-	psock->saved_data_ready = sk->sk_data_ready;
+	WRITE_ONCE(psock->saved_data_ready, sk->sk_data_ready);
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
 	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
@@ -1273,9 +1273,9 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 	psock_set_prog(&psock->progs.stream_verdict, NULL);
 	psock_set_prog(&psock->progs.skb_verdict, NULL);
 
-	if (!psock->saved_data_ready)
+	if (!READ_ONCE(psock->saved_data_ready))
 		return;
 
 	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
-	psock->saved_data_ready = NULL;
+	WRITE_ONCE(psock->saved_data_ready, NULL);
 }
