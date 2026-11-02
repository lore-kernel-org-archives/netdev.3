Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793624019;
	b=tCgFlqoY69bJTAaQAv/eSOmzhbk4JRKmPMYwCtofcuhhh5ZTsxxiEubQBfwSCxJUIPaa
	 +DZSXKLyqcaTLcliiT+owAj/pxeW9qJxz+WmWQAWjO2Au97XcInGfRsOpC3ldYRfLCyoZ
	 9BYD35c3epYVn0IE2GWRGimiLCIfioZ5FviR/yHt5PPvtHj61nZSh/8BzIooANXhm4Ljy
	 yEsDTZ2S+2yBDgJw9KirC+wTf8ZZ7bczYo3reC57ighpeUXqtjPQNrbxd97zk/7CdTJ3r
	 o0zoqB/hxnK6jFVbeoWmgvmqLZLEwLrpQkoImhgWg0lNtbgm577h8Quk8PdJf/KmE0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PKWzOeMbtoREvXP2uKxA/cmZW6EK1zXaCrtl6yHjImQ=;
	b=kmMQgXwy77FLX1J+SoRpH6vUKu7ov0obstKbsc7rLjaSeM49zGRLorS0iQRkatNJH0YU
	 XoWjJIscXy3m8+3xOYXl58wSSuD74RFDQjZ2sAuvQCibGUNzs2aA5GrPCVed2ud+kcApm
	 87KtRtiXfKVpGEP2SME6fyTPnEsqdp9RUTqNpIaFgtXkPRdHFFY6qFb5F4jcQ0drz0sEf
	 Yl6BFZFKDdl1MsYRBfzcbbmVNXaTOW3GMff6/VVQm67k7BXmJG4dES6Vz3QpVeWHtgn+M
	 tVfCtG3e45cxysLgIhbngHnD/rXrfPdxO3CgVNSQiJAMtZM2yrnnxZNSAGB5CAqzb4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S1/YtTr2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BE606A331
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B46BE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1/YtTr2
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so2866932e87.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793624017; cv=none;
        d=google.com; s=arc-20260327;
        b=lMnOrdO2JFEMVDFIbtWza2wUII6f4d+znIdIRiw7BKjSBzxCG0BTFairLAw4yb9K2x
         9JzjB2W5XYxFLJ2a3DsmoBTQdYU39SRhvBSEaoiw6gA3uQh0FKH5gw1V0HqgTeDlFCUA
         Eod+Rh51aKxoHQSO3OM2ciCeCDZfIpdjNOqeh2iXqkZO3zAigPe9JPpZNmYXPrPeC/+O
         ZwKsE3NMvA3gAhETufVgNAxz3ts2y9okC7Q5S1gMSOkgXsLldHYR0LTH+mq2iJbcZz/0
         Eq8n3Tk6uU+KJ9TtvtNq8zaWc/60c5kp9tQ7+Pt11FqEv3EH5UQHay4nGXw5RsmGUuzW
         xgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PKWzOeMbtoREvXP2uKxA/cmZW6EK1zXaCrtl6yHjImQ=;
        fh=CvjwpP4aA99ptLLFJjXSgfGDBQq2fgn7+EToVpKmgwg=;
        b=jaCtRXMfUj5Gq+8zlpvs3tZc+fLvYRBusCUqSC0QC6wnQRPDwhSmjzi6wW6EQVIbZZ
         b77/2mw+G0z8ysnSFLuEgMWopC1hFMHMNGIeumnMZkMQOan7/CbXzZRLn/R5ny64+40k
         LF/TIX9NKqkSiV/14bxelJNAz0euTcWM84kOnP8Kg2cQSj6XvVz6WGEUiTUbWQ1xyHff
         4sCNWi2bwfGIbOO4u5BEYMPv4OHw2RVZRouZ/zqwztuTGrHjySy+FcUvTExqcBBRc5O6
         b1EHwBSeNY+1zujc/WJVGWRsOn9yNx3CRySIDVNrj6H0XCNTepSbGmNqGNt86A21MGFO
         cOIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624017; x=1794228817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PKWzOeMbtoREvXP2uKxA/cmZW6EK1zXaCrtl6yHjImQ=;
        b=S1/YtTr2MNs+kInj/pmyyuczrtxymRI6PUqq5bBq97aTGnexqibINgLL66GkAoJ1JR
         hqP12W8wA2yc4uoZcBmdGoUttyfFRC3blNxUTWSgM10xO2rCTJkhqgQLaj6yS99fF2aI
         M8BnXulzbRBmRBs7H9DKX0X5J5Q1WZxWGNmDuso/tdCFUvVk2H2S1ifbF+XCV+cVrObG
         kCT66eBMKk4kCxp+DkrWt2yNp3UOOcKjHpsl8wAbRDAENAKeUt9lsKuOd63cKp09jm9X
         tzIGiQSrbXlqEDKGliEkgGGV1bN8S2YKGxwOEk0WTY3z3LsUQ2c3rQNIQ3fTUH+dtYgx
         0AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624017; x=1794228817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PKWzOeMbtoREvXP2uKxA/cmZW6EK1zXaCrtl6yHjImQ=;
        b=Stxgm0FL/ma3ch4g7A5HQXfR6kz1sKjXzc6GTxKkTvDrkruLRu/XthIXaDQ/WnAfAf
         GPEhsvh/CFWosOhFVHv4f5XSshSWXtZGojL9GEF0ohrPchz18l84XP51MyCHzTB10696
         2R7dQt6hZYZmvYVBP5cFwcLFYn29levc0zbicQN4z8IGTQ//afWjyTKAhNSJviIFvVUG
         mal3Bh0Kg+BDZCDFdTtBJ8R0j5KNAGRRMUyrvH3767sfzWnKA3/EDN2UM/gYrysFdAuF
         QEsNv/Ywv0mekY2YF2ZsM1wn7PAewxa+W+GXQzlOSrYVpDxuI2vV8OiBH27p1s5HuReB
         452g==
X-Gm-Message-State: APuU4Z8+c5P42qWO7E1+VzrQS+2eJ+lvtfhF/nh+2CLJlXYODZxeQ9O2
	5NjA+25CcF6qyduRX8bDnQsZYVWo55YgYADcnODdVx43SbMB1b+7wpWsDoYKg2PmX+tEAGpJfO7
	hl9mXhDrO8om44EkLeo65NfdeJcW9ja243SEC
X-Gm-Gg: AYBFou1sT3pXU1wFHjakS6JwUkKng5sxJf27Dd2rX65+FceoU27TgdPLOL6Bt5XEgIz
	C/BXMP5yJTZmFaj5t5mvtRHxanBUskjmbttTYziO+ejv8r4gXDwmoVbSrJk3XOJuliHHOOdbEq0
	lzkHGMYQGFUDp659kutKDlwdEsN6FthcmQnxck5gG84VU83N5bjKphKTtnd4DhUcNeoTGwAjnmW
	58DFvF6RddY+Wmd985xM3MZZKSmE/swFwpkYh0jX+Ah+58RTfveyNg334VXEkm8tjWaOUEfPRu9
	kcMk5qZicZUPMWCH/Pk6YaHk2HG9UB2esgYNsmGIseCmepw2t6wnCC2SrZMFABU6k1+Hd+saKHJ
	HBHXwlpoO9hesdqJsSDXe1zNH79+Zaph4q+aWYA==
X-Received: by 2002:a05:6512:3d0c:b0:5bf:b5bf:e92f with SMTP id
 2adb3069b0e04-5bfd9560681mr3075383e87.20.1793624016687; Mon, 02 Nov 2026
 04:53:36 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102120929.4077030-1-anilkaushikwireless@gmail.com> <179362163558.3286.5335895869912806815@kernel.org>
In-Reply-To: <179362163558.3286.5335895869912806815@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Mon, 2 Nov 2026 18:23:25 +0530
X-Gm-Features: AclHuK9PyreJTBljW7ZzmF0xOz3S8xl5coCWXAIofZgHiGIZruf3wtHbRZ4qAYU
Message-ID: <CAG0Mgm9t=ag05xgP8f0++x0sNG6nOt9zDWbtoKLtgnhnpgm3Dw@mail.gmail.com>
Subject: Re: [PATCH net] netlink: Do not call the unbind callback with the
 table locked
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 5:43=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Found by Sashiko, not seen in production. I triggered the hang in a
VM, with a test-only msleep() to widen the window. It does not hang
with this patch.

Regards
Anil
