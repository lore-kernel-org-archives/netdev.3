Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813218;
	b=nkWLsYPyGe/5OK2VohsylC5a8r83HzBoHXnF7RJKJNPKKUdvZiSM6p6FQRAb7NuZ+Xm2
	 cOwMamSmjtB86myzJ6RRlHK9dq9I947UtjEv42IMzudqwj2g+YJVicu1zlHgioo2f1lje
	 bAIZzP4l7+9Zpkh5uL3VFACCh4lsz/sI9yNbVx8az/+6wqle9Ksh1LXmgPKYcx1ybhFsO
	 wl/4lUHDUiVM1VrsviI4m1riByABFU/pkdfOCf14qGqselrbPrGj7RehQwSiASn5ihdZ0
	 IhyTqNotpIUy1bLcW6TRUkK2h2D0f4MdkOvD3OA2jY7fDZTLvGHxXk3eG8SHAdAqM9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:From:To:Cc:
	 Subject:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AIXcoMlb0b5yCSVTF+JTOpkdtPc0CeYesRDQI/M2QI8=;
	b=KS4/+xrpdJvtVbpvW6ktsJKgKYCMHstdHTFSWcMrJs+d1Mz1gVMTjj6iHZFkhPZWcKZ8
	 qkzQcCSEKr5n+GuOZfc+zFk+r7QC0yCjwSpH0GuNErFzcto6Ky6MZUDkAr23soUxUuhE3
	 AM3aiHCEsBcZMF5Ukx7s6rZiErrCWP4xbtwdrTd3xQkhyfy6aS0tgK+YgscDSCfWg/0eA
	 9vsEExK783QQpa6jCdIvb0xhCdGPif7NfmeOlte7Pu/oUWq8Sdu7dVYN5kaFDshPypAgi
	 shFNWYHuPr6zeLQp9KZ0VujuxhFMclUBvQ/rNPmHTPQdqHerwB7Vtjh4istujiDLE6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpWpW1cE;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E8606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559E8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CpWpW1cE
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5363316fa0cso10406331cf.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813217; x=1794418017; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AIXcoMlb0b5yCSVTF+JTOpkdtPc0CeYesRDQI/M2QI8=;
        b=CpWpW1cEe70x1Gd1AAM/WKUEEPCnI1xVQRpWAIWOtqD+ftG0qI6yrrZmqiY7IDnqe1
         egCoaH1qWXoImfPI7EXS4TMd53/BTXYfesnNqar1tdOwsiy2XSo+ymiMQ0teSRNrVu5/
         PEb7YN1hTxdqifVlfrjVN/0mwX5HPc8L1Wa+is/ILfM9psdILTW8iRe/+Xgei5LmWPhL
         7iS+ywyqPNPMH3h8aPxHfUjD54aCMU2+urA7rkg9l89SoLlwGtMn/ZaU8rC46F8FK8Fr
         /q2PKqGocZeK6zvUfPXgVkQWz+QXSVsigQU3RC68k3p8UXt7xVymBHCZBq9Vr+EF4jk0
         u3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813217; x=1794418017;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIXcoMlb0b5yCSVTF+JTOpkdtPc0CeYesRDQI/M2QI8=;
        b=GzUFzP6t9Cy0rh1b4+hb+B0ce9CIeNM6I6y2vVWO9rK3FKj2kiXVpoDJq2HULRxYDF
         QLBLyRzjHekLZ0aaqWqOzQ928vZc2t3LfZLtW4OkKhBl7Z4CQuzG7sk69jUt21YzOCd3
         Hrok8xwNMj6bfpBT1iHodstClgj987Ihs1jJ0qycUJny0lAYKTmn8NAwaDWcU4cd2YLq
         dWSvCCwLmPnO22T14Z1H1RspD3OpHJXFMTwnKgzXP5eYy9nACFqVpeHA8ucKMYRKnYKT
         LMEGDF3jey4DFxU9JjG5FvEuRQ1dojin9FD6Eb3ag3YC1ovd0BcR6kJlPguR3YnAl5Yt
         hIJg==
X-Gm-Message-State: APuU4Z9821b/qrosG5lIecisMsQ1QYFhYoDpq8MwvyGTRYNHjKeo+jR4
	tkPWoiYKUs9c15S5OT7BhD6KY0Zynuucu/EeRsfuO32EcZNtcbE3KezRkCQ1Bsct
X-Gm-Gg: AYBFou3r8/5CWu2/N4dtSBaVZPmD1pt5HWMNe0oqXDFvGrQ1zJePPFl7mTwnQCJJmS1
	5x9Kgk4tQgcbbA0K1BZOQ9xzrAH21K0/nOYTLY5itFQasIKYrxQ7dfSs5VQGv7ESt2yijySOZ3p
	hgvNpHPSrD5rEn6BIS6n56iaLIfXln7iSwXF8P1/Gwaijqk+ZAVvvANh4ZdoFBdICA7bwWpuAy8
	XkpwitpsYzIl9DYnrKZhdP9bFFQVq7bKndIZpeq75tyk6ZrJXQIMC67Z+WgWHDlOfll4zxTWq0/
	Y0DoeosnbxkIvOeh6fC1UFMr7QLgctPBXBBUUXNYxC6/60mUJnrI7vzOThtoqeddk3BGQWREb7/
	UM1cVh25R8YQIQOlbMXrZliZHQ2ad6MAJxsVq1jIdXmd7tM6CLHcW6umtOOv/bMhVm/jLr75CXV
	62mTqzU40tjNVxpDL6Wapejrj9yPgWvvZJQ89/SKiz4VD7ENDI8XYDF9oE+VAiEdZAtllppLRNi
	g9SxdQ9y8iipIvYlD5xtxBn+ULOE8yBPV0ZSsjkBzPy3eBAW+yIlXMAio6BtWd/F76AsGccd9JQ
	/O+kXi+Sp+mY1glw4g4jHwI0WBTln+WDKpk=
X-Received: by 2002:a05:622a:588d:b0:537:636f:b31 with SMTP id d75a77b69052e-542b85e8f17mr275202851cf.73.1793813217222;
        Wed, 04 Nov 2026 09:26:57 -0800 (PST)
Received: from [192.168.100.12] ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a7006asm29173931cf.17.2026.11.04.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:26:56 -0800 (PST)
Message-ID: <6aeb6ae0.8830561e.c5bb9.8831@mx.google.com>
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH net-next v5 0/2] netlink: specs: fill in the missing ovs
 operations
Date: Wed, 04 Nov 2026 12:26:50 -0500
In-Reply-To: <20261103183319.2730567-1-houminxi@gmail.com>
References: <20261103183319.2730567-1-houminxi@gmail.com>
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

Adding the Open vSwitch maintainers, who I left off the original posting.

The series now touches include/uapi/linux/openvswitch.h, which MAINTAINERS
lists under OPENVSWITCH. Earlier versions only changed the YNL specs, and
that entry does not match those paths, so my CC list stayed the same and I
did not rerun get_maintainer.pl after adding the header.

No change to the patches.
