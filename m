Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090A3AD539
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798933; cv=pass; b=J5YjYlIAuYVGwPkUOgNlBsiJnVURLWiwnEknmdgI/j1ev/SxeHW+LbELp08c65aMZsKvP2Ah/frax1k8GH0IDUpBt3MLGXo0PaUZFL+syw07KRp41BNzq6NupWc8UPUkF7rQqnLXD4ILSGhyABkoJfm40v3MCHXmG37SQlqV9dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798933; c=relaxed/simple;
	bh=bhtUeTWaWQoRsIUq3/0NhMF4yFZyZl+XUqrKwbDuapg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak6pUMprxut5kWXokl+BXMxEWJFX6QE3IEeKL/RVsnhCc6/Be33PDkpnKxg090yhMhiVKgpqJN+iAt6myh82imxmfD4on/Ux5EwyPtOP497hX3qgKStxc4keTtDsRi3de7GUMAwssiarYQcu0JQRt7rsVRgsbgQGw44MOdeQqaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvK3Kal7; arc=pass smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvK3Kal7"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81f55c19dedso1203765a34.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790798930; cv=none;
        d=google.com; s=arc-20260327;
        b=CqDk+bBNF1Fu8N8x8lL8VOB+y7gK75zcoZa2KJ4hTqvlLjqghdsoIruCZ63P03q6l+
         mXunZegSekB/Kp72D01v1WPTijeGHgB+aT3IWDT0LF6e5beyd7uAitBm6/lge0pUBXIe
         nZFWz7GM67Y17ClOJMdoqVKhFt0W1nKA4Ay4W0vBrg9MlPFhDURhaF2KcZa+YQL/B/B7
         Y3i6AD9yclGAH/AXx9mxF2gfBEKXkiSq9R9UenZpKxjKRC2J276xO+q4Bsr0wgqGfa6K
         DsUt+oYnPygT8wQgi2USc5gnxMr9/ol7UyAWtvNqc66IFsAUn+7mPEofw3HaWLQVaHFu
         OF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Ik9zrwtFn6RF0L/JldoutXppR184+mdsZlk8WWANp0=;
        fh=r53QVSA6ZV/bwnQW++EiSpnuu/eblTW9gsnkWnG2ehA=;
        b=nSnrIIuS5oDR5NPrfz0MtOQZ40vEWR1YFylU8FpqtfHofKQAz8SrO8Lh1HZd3Z0FDQ
         PQdSuQrMNLpZQklDUS3mb5gLa5W3KydTVSYMBfdUylb+K7KLtc/hSQiJTLxPJCRN0fCD
         mNL02f8TlzTe8FaK56I6Ms1DugIZKVloGGzAqkTbNQCDIoTlVvz6xqmepskmOs/i5Bqg
         qNrOHTjDAt8N4FLaEzVGVqgxmh3WW3wCf4QCPEG2dVgAi9+CWLYR3XwSolmZdYeewzoQ
         oJsGFemOeejzb1Xdu8RtuhkKrt8r2mMJAkZQP986SfQ7Dpf11e/Ki3jMZnTD++UQFcMQ
         FpNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790798930; x=1791403730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Ik9zrwtFn6RF0L/JldoutXppR184+mdsZlk8WWANp0=;
        b=IvK3Kal7LHelIO9CBzwz5UGRF9lFfu5vsZjHENk4M6NNC725xN8yp3+15VlEA4HO4B
         udkd4FvA7EC5ixbZPsfW4UR2sjQpuLtGWSV5kSNvMbrRkVEY1vmnDXrwDR9mB4UtMvCs
         Rj/VlLb7Gah6jEKfS1eg+I6Oz4/T9A7vYxBZYqgdO9RL8lCsYtFZpNgiz4I+hP3Mlrfd
         lPcBGjnQ8PyDLcMl+odSytmi5qHfW4nlirA/VBwB96wHC8ue6vxlUf+uyOmT39EBfV0e
         eg0jEhTCRUMXDBtWxmbAj4O2jyUkrvixJnmG+DvT68OUEGqYwLrD/7uV3uu+NPBrYc9n
         nHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798930; x=1791403730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Ik9zrwtFn6RF0L/JldoutXppR184+mdsZlk8WWANp0=;
        b=YIobRuLSN9lCoQUEsRLpArTXHa8vYnEoUlyC0UkD4QoREPjIb8OReOiZ3LOEkGFi3n
         tXBhkwKeLAUvBqoADC8R05HY+3QebKdSLSG+NQx45DCeuM2XcYDFBXksyIFLcjmJuFOL
         3ifc++xcF6dVo6NybXkbT/abCJGjWK8IdmvSLzzVSRSDKppFAVy/tCz93obNe7qtCwNQ
         oQP5WWj7OJzGplZ9aI7ViOQLj4GneA4kCrM60jIieW5lxj77qdo1JPTb8kHiMPD6LTG1
         x2aCP++Yb7Kw6tQjhIugPAlmArLJKhv4qgEynJydqGQuQuaT3LAmEMa2i/ARVqxcN8+7
         hjQw==
X-Gm-Message-State: AFuF++m7UI+kB/Zo96yM8KJvG7IAlofSFwafsTrOb1jvrwBrZl6w1MtH
	GqHZAQgRVjZGr9Vm1KfNJk0ekppw+qaYp1Y2JjH5ZXMTgcSfpJyRGZdLwznniE9XE69LhyASo5h
	2ERRquTaGLcvMQG4xzNRjVM0lnF5X4DY=
X-Gm-Gg: AYBFou0+FHPzlS2ss19nQMY8etBjQSgv3vX0F8wv9MjWBNF81038Ui82uE2wKBoaM6X
	DnslgqrSftka5NHbfFRS75DWhBM6EJdepU6DwWVGktw0BYZoeFPZdnBSWRXu0uGiwcJTdil1JXJ
	hjwM0c9JSnXMVoF+j1LKQBz0pQmlV76cGDg4yZSQK7IpfVWU6rgFdUKhtJndle5aKgzwP+vzRff
	pUoxJ3FXu0wT8FoWLgZxN4QKFD6ED12dpNiLZrQSag5MUwT2eby5tfoHdM9JlfNQFHGEMAtAyH9
	7sApOQ+rglB5xclTnL/gmLdxc0+7NKRXwqYOWAc+hC2TY+6TrenxzSbRFktETm71H4X3A/yg0M2
	ALIQH9zG8IJtVGLqaiV9GaUS85bKjMl0OOUqk5UbZcpcTjr50bzfHZ48N
X-Received: by 2002:a05:6808:3a17:b0:4e8:3e98:6f61 with SMTP id
 5614622812f47-4f1b14e6776mr3417147b6e.3.1790798930119; Wed, 30 Sep 2026
 13:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930141151.3973221-1-mmyangfl@gmail.com> <179077766581.31693.7541948300673794721@kernel.org>
In-Reply-To: <179077766581.31693.7541948300673794721@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 1 Oct 2026 04:08:13 +0800
X-Gm-Features: AclHuK-snbmRVDYyPlolIVrtHLv51eNL6dnYZYFPumbUT0rmQ_IO9EolJhzK71A
Message-ID: <CAAXyoMPUhoDNk_CFLXn6oV853Y1wwaJhyigEH9TmaKGnARN-6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Fix register rollback in
 LED setup
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:14=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

This is a catchup patch of previous misapplied old series version.
