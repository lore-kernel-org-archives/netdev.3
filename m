Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E0233942
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791508357; cv=pass; b=bTtYNXZjHhf9zTBMTFYpfanSQUa0oXDzjXvya8DBNs4jdVwdMgjDDUSqxKX2rlj9m+Qha1waUWxvSM6IP9kjUjjf0vv37hIMXcNuUmgDmSSEt8gt3X9saNgEPZVwxkFdiVa3eentF/SKVKSqOHDXCdloFeP+rsRNFXak449wx8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791508357; c=relaxed/simple;
	bh=2bXMDwVEYUSw/XMXG+524Ph7e3RM6JayBzXlJizXsCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZhmZ3Q63m27FluLcfsEPL0FYTZS2bUv5fGiBGLafLUt0IFXVK4XrCtpWCkAbEhSU4y59cCmn/eP9GyYOcfUdRitWdxAX5DcX77qSl+eZ/P+UbRZbcEwbTAcGFtrAX5XJ1HoVEul6GWAL1pPwJDEf8V4SE1lbTPeC0EiFi9w9c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR4OtYHV; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR4OtYHV"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-891d19d00ceso917839b3a.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 18:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791508356; cv=none;
        d=google.com; s=arc-20260327;
        b=n8/b+gGZLj7sYvR1HFU3fsTkNus+c2kL0nXDFr0UONG3mCaY571PKqL1yK6HVUuaEE
         m4nPkW7gUn2fPyRJWMeFUdkxWscHVbAVl9+MZwobwGkIVWlTsHGw5h6dJMCIpTvMB/CX
         guPi6OvjrpCZGujr8w57zgytzoo7TGoMqC+7ZuZwO9cerzkWeZLUN+3K3hdGZtY2gIdN
         j3ZNf88zfqwy5RsjmuePSaY5LcG8RhSffwYRX0rXxmEWC59XXBMvN3D11YGWig/7wkSy
         woWviX535FYWONZCJ75v9T6oRkbONWpHpkOjY3SdMh4Yf6tYWUe1N8yqu7VfrZayT7sw
         owgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rhKDa4MSCyA+5vwLc+awp1rXxilBjr3kpw4ZExutEJg=;
        fh=3O48MYtcHjPSS5t4eEUS3FE5a+IsMyv+gskQfqrgCxM=;
        b=mF2ao+iRMP31LbS1Cv12mhEcT/BH/s6Yd3YELsW9SNc3B4E+YLtWLv1VQFwkcxk4hF
         QThKBfS7saURyeJst1usCovum0t2n/5vzHhwDyh2QZcY/TCddx+hh6x0AlRCc74vcMHG
         /w3Jayz6kB+IuKC2F8aIk0B2It2ONsSWvvLhWOKVSiz+3eudaB4SfMLWwoXRZZ/kAfYH
         g1+RIzxMBI8lvnMQM/xmc13/kEc4jJBpgrdyZb1YbmsBeujxNTgCN1jD528ewDLVi3xX
         D4A1CpIibO1Y0DgklmCwQQGTSL0mTppLNnHeL+rebuMrU0/UZQ+5E50kqOCXahYCCN+P
         fECQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791508356; x=1792113156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rhKDa4MSCyA+5vwLc+awp1rXxilBjr3kpw4ZExutEJg=;
        b=cR4OtYHVgcibPwmHiavkY/FAB5ENYmg/QDtUb/1IryRfPVgKg+ubFht40ut4t7WU1A
         oMqT9r3HYcVBB85yVxtVOy+JF8zVQbSQCJ/oNyWKav6AaAAZGp5yD4DAyMHMk7yLWJ6B
         Fyao3AgC7Q6btwdwe0WMjciuc6YHmwdpZ8Bnq94uRN/Ny5lpCCSv8RzNaY+ZjbdK7Qxi
         NwnCnTgc5Hn6lD+hqrlMr7btrpWuR8KYiaUOVKiUIZJ65r23Liw+/d9CqtFIgkyp5gwR
         nJO4tV132WxG9IpaKgxRj/rokle9+w8AYRVYyAcNHy32PbwSiux8B4Bc58QYCHsnC5Gt
         wzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791508356; x=1792113156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhKDa4MSCyA+5vwLc+awp1rXxilBjr3kpw4ZExutEJg=;
        b=ILaTuopHitFYYMXN7MG+agkwlD6nJQgrXXb7pXRMUPW+d44sKRZRCsqm686FpchWQk
         iwFFGLBHBlxtodB05v6JfdVLsKxEfOEDqLDM/4z9Xz5zPkYQaH9oK5T5ezmGhqzq4yiK
         VUBGTGk5iAMn0Lewyag0kWqhKBmpGPtUSRnlywt644KmuNm6Uc50DYpEdRoMb+Hnn8tF
         G2T6Lb3MkP1mj3X9wA7p55iNC2xEu4koiTw3HgayShTmHcJaPht9jLL4XMfJ8EX2DmQ6
         8wO3QaxEHqErSRt+qr8Cw6zAVE4P+Opf/pIrrsan+MJMiBfs3ew4Ozl1/8bmD6eSnfcb
         MYVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZ8fjVNThYngkZMGKVIPVLY1ROfMcI0OKLB865F+Jfi0jLvR8csjFxl1b6mE5wDPwuVWmg7QM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJj836xYN4ZMxa7Q4ceZM64mST3htl5YF84JOS9GkRcuM8qorBY
	JKThRl+N0TaMeFWc3MOGN3+9dVhUJgNpbFdpJVg70pbhHVCc5obWJwNJqIrrc9K5l/H667opDvy
	pE0bKWkul6YQEienevylrME+TavKGSzECKUlq
X-Gm-Gg: AYBFou3ROxY4+A7o2LMqaBji6CkOK5nzzVLUg8Y0mkz+XfzEzbANCM+2Rh1685ZqyUr
	jAhC9bDfZWttemV493FrqyWwykNJaGwhWzLndAK2YJBaTE05xlzMcTGZtsb71p7opMcjjY06JPq
	pECBVD9mWGZKwNWhJXW9D59vyiW+GB4GK6pVdrrmlmdZg+S9g5NMYq8bZWNIE9+95fOXStjoF1I
	J53nKwGsZwWd0e7xuDKIP6G1PFaSS/V25CBgHgOA8GVIa0+hzO8f5awSVB6f7D3SegrHkb9NbUl
	kOOUhYgU2fdHyB1R5Zdv3p4s5y1PgLPNnH/bGL5qmsVyaSgBUIi5zTLU7MXx7AiV6+3ucSIZPKz
	NP++6GOejt1NI4jjpc5+FFytajglItm9rnbF28J36bMUWFmrCHoiw
X-Received: by 2002:a05:6a00:178f:b0:88b:72d6:b80e with SMTP id
 d2e1a72fcca58-897c5d55bc4mr259823b3a.13.1791508355601; Thu, 08 Oct 2026
 18:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007035739.3472432-1-4ncienth@gmail.com>
In-Reply-To: <20261007035739.3472432-1-4ncienth@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Oct 2026 21:12:23 -0400
X-Gm-Features: AclHuK_m_kMGuBUY_F3PNA9Ts1xvaJcfDaoJFu7BhbCtEygkfb1YNmNxMxISybs
Message-ID: <CADvbK_fEWi7XFJgU-7Zo_pQ-a2AiQoJZHs-jhspYQ7xgNCKNyg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: revalidate output stream after association
 connect wait
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 11:57=E2=80=AFPM Daehyeon Ko <4ncienth@gmail.com> wr=
ote:
>
> When message interleaving is enabled, the first send waits for associatio=
n
> establishment before building its data chunks.  The wait drops the socket
> lock, and handshake processing can reduce the output stream count to the
> peer-advertised inbound stream count.  sctp_stream_init() then frees the
> extension of every removed stream.
>
> The sender resumes with the stream that it checked before the wait.  If t=
he
> peer removed that stream, sctp_outq_tail() later dereferences its NULL
> extension.  Fatal-oops policies then panic the host.
>
> KASAN: null-ptr-deref in range [0x38-0x3f]
> RIP: sctp_outq_tail+0x49e/0xaa0
> Call Trace:
>  sctp_primitive_SEND
>  sctp_sendmsg_to_asoc
>  sctp_sendmsg
>
> A range check alone is insufficient.  Stream reconfiguration can grow the
> output count again while the lock is released without recreating extensio=
ns
> freed by the earlier shrink.  The stream can then be in range while its
> extension remains NULL.  The send-buffer wait has the same issue.
>
> Factor the range and extension checks into a helper and repeat both after
> each send-path wait that drops the socket lock.  Once the lock is
> reacquired, the validation remains stable through data creation and
> queueing.
>
> If validation fails after the connect wait, the auto-created association =
is
> already established.  Return ESRCH so the existing caller path keeps it
> under state-machine ownership instead of freeing it directly, which would
> leave protocol, counter and socket state inconsistent.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Acked-by: Xin Long <lucien.xin@gmail.com>
